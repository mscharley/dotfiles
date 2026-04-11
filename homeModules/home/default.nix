{ pkgs, ... }:
{
	imports = [ ./desktop.nix ];

	home.shell.enableShellIntegration = true;
	home.preferXdgDirectories = true;

	home.packages = with pkgs; [
		# Terminal apps
		jq yq-go
		asdf-vm
		most
		starship
	];

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "25.05";
}
