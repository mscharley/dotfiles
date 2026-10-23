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

  # Provided by nix instead: nvf replaces the lazy.nvim config, dotfiles.git-extensions the git scripts, and
  # programs.{bash,fish,zsh,dircolors} (see shell.nix and friends) the shell configuration. Some of the shell
  # files are still read from `configs/` directly, but they're not linked from here.
  roots = [
    {
      dir = "home";
      base = home;
      rel = name: ".${name}";
      exclude =
        name:
        lib.elem name [
          "bash"
          "bash_profile"
          "bashenv"
          "bashrc"
          "bashrc.local.example"
          "profile"
          "zshenv"
        ];
    }
    {
      dir = "xdg/bin";
      base = config.xdg.binHome;
      rel = lib.id;
      exclude =
        name:
        lib.elem name [
          "git-cleanup"
          "git-cleanup-remotes"
          "git-main"
        ];
    }
    {
      dir = "xdg/config";
      base = config.xdg.configHome;
      rel = lib.id;
      exclude =
        name:
        lib.any (lib.flip lib.hasPrefix name) [
          "nvim%"
          "fish%"
          "zsh%"
        ]
        || name == "dircolors";
    }
    {
      dir = "xdg/data";
      base = config.xdg.dataHome;
      rel = lib.id;
      exclude =
        name:
        lib.any (lib.flip lib.hasPrefix name) [
          "nvim%"
          "zsh."
        ];
    }
  ];

  # Same as get_filename in install.pl.
  targetName = name: lib.replaceStrings [ "%" ] [ "/" ] (lib.removeSuffix ".example" name);

  isSeeded = name: lib.hasSuffix ".example" name && !(lib.elem name promote);

  # Every entry we manage, with its source in the flake and its absolute target.
  entries = lib.concatMap (
    root:
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
      seeded = isSeeded name;
    }) (lib.filter (name: !root.exclude name) (lib.attrNames all))
  ) roots;

  seed =
    {
      seedSource,
      target,
      isDir,
      ...
    }:
    let
      t = lib.escapeShellArg target;
    in
    if isDir then
      ''
        if [ ! -e ${t} ]; then
          run mkdir -p ${t}
          for f in ${seedSource}/* ${seedSource}/.??*; do
            [ -e "$f" ] || continue
            [ "$(basename "$f")" = ".gitkeep" ] && continue
            run cp -r --no-preserve=mode "$f" ${t}/
          done
        fi
      ''
    else
      ''
        if [ ! -e ${t} ] && [ ! -L ${t} ]; then
          run mkdir -p "$(dirname ${t})"
          run cp --no-preserve=mode ${seedSource} ${t}
        fi
      '';
in
{
  xdg.enable = lib.mkDefault true;

  home.file =
    lib.listToAttrs (
      map (e: lib.nameValuePair e.target { inherit (e) source; }) (lib.filter (e: !e.seeded) entries)
    )
    // {
      # Checked by install.pl, which refuses to run once home-manager manages these files.
      "${config.xdg.configHome}/dotfiles/home-manager".text = ''
        These dotfiles are managed by home-manager. Do not run install.pl.
      '';
    };

  home.activation = {
    dotfilesExamples = lib.hm.dag.entryAfter [ "writeBoundary" ] (
      lib.concatMapStrings seed (lib.filter (e: e.seeded) entries)
    );

    dotfilesSshPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "$HOME/.ssh" ]; then
        run chmod go-rwx "$HOME/.ssh"
      fi
    '';
  };
}
