{ config, lib, ... }:
# Lays down everything `install.pl` would, so a machine uses home-manager *or* `install.pl`, never both.
#
# Mirrors install.pl directly: every top-level entry under `configs/` becomes a single symlink (not a
# recursive tree), `.example` is stripped from names and `%` becomes `/`. Entries that are `.example` in
# the repo are seeded once by an activation script instead of being linked, as install.pl does, unless
# they are listed in `promote` (static content that doesn't need to be user-editable).
let
	configs = ../../../configs;
	home = config.home.homeDirectory;

	# `.example` entries with no user-specific content, linked like any other file.
	promote = [
		"gemrc.example"
		"asdf%asdfrc.example"
	];

	# Provided by nix instead: nvf replaces the lazy.nvim config, dotfiles.git-extensions the git scripts.
	roots = [
		{
			dir = "home";
			base = home;
			rel = name: ".${name}";
			exclude = _: false;
			# Dotdirs directly in $HOME (ie. ~/.bash) are real folders of links rather than a single link.
			recursive = true;
		}
		{
			dir = "xdg/bin";
			base = config.xdg.binHome;
			rel = lib.id;
			exclude = name: lib.elem name [ "git-cleanup" "git-cleanup-remotes" "git-main" ];
		}
		{
			dir = "xdg/config";
			base = config.xdg.configHome;
			rel = lib.id;
			exclude = lib.hasPrefix "nvim%";
		}
		{
			dir = "xdg/data";
			base = config.xdg.dataHome;
			rel = lib.id;
			exclude = lib.hasPrefix "nvim%";
		}
	];

	# Same as get_filename in install.pl.
	targetName = name: lib.replaceStrings [ "%" ] [ "/" ] (lib.removeSuffix ".example" name);

	isSeeded = name: lib.hasSuffix ".example" name && !(lib.elem name promote);

	# Every entry we manage, with its source in the flake and its absolute target.
	entries = lib.concatMap (root:
		let
			dir = configs + "/${root.dir}";
			all = builtins.readDir dir;
		in
		map (name: {
			source = dir + "/${name}";
			# Interpolating a single `%` named file would try to copy it to the store under an illegal name.
			seedSource = "${configs}/${root.dir}/${name}";
			target = "${root.base}/${root.rel (targetName name)}";
			isDir = all.${name} == "directory";
			recursive = (root.recursive or false) && all.${name} == "directory";
			seeded = isSeeded name;
		}) (lib.filter (name: !root.exclude name) (lib.attrNames all))
	) roots;

	seed = { seedSource, target, isDir, ... }: let
		t = lib.escapeShellArg target;
	in
		if isDir then ''
			if [ ! -e ${t} ]; then
				run mkdir -p ${t}
				for f in ${seedSource}/* ${seedSource}/.??*; do
					[ -e "$f" ] || continue
					[ "$(basename "$f")" = ".gitkeep" ] && continue
					run cp -r --no-preserve=mode "$f" ${t}/
				done
			fi
		'' else ''
			if [ ! -e ${t} ] && [ ! -L ${t} ]; then
				run mkdir -p "$(dirname ${t})"
				run cp --no-preserve=mode ${seedSource} ${t}
			fi
		'';
in
{
	xdg.enable = lib.mkDefault true;

	home.file = lib.listToAttrs (map (e: lib.nameValuePair e.target { inherit (e) source recursive; })
		(lib.filter (e: !e.seeded) entries)) // {
		# Read by the shell configs, as written by install.pl.
		".xdg".text = ''
			export XDG_BIN_HOME="${config.xdg.binHome}";
			export XDG_CACHE_HOME="${config.xdg.cacheHome}";
			export XDG_CONFIG_HOME="${config.xdg.configHome}";
			export XDG_DATA_HOME="${config.xdg.dataHome}";
		'';
		# Checked by install.pl, which refuses to run once home-manager manages these files.
		"${config.xdg.configHome}/dotfiles/home-manager".text = ''
			These dotfiles are managed by home-manager. Do not run install.pl.
		'';
	};

	home.activation = {
		dotfilesExamples = lib.hm.dag.entryAfter [ "writeBoundary" ]
			(lib.concatMapStrings seed (lib.filter (e: e.seeded) entries));

		dotfilesSshPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
			if [ -d "$HOME/.ssh" ]; then
				run chmod go-rwx "$HOME/.ssh"
			fi
		'';
	};
}
