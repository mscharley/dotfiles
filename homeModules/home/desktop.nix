{ lib, desktop, ... }:
{
	imports = [ ./kde.nix ];

	config = lib.mkIf (desktop != "none") {
		services.flatpak = {
			# The default is to enable HM flatpak, if and only if flatpak is enabled at the OS level.
			# enable = desktop != "none";

			remotes = [
				{ name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
			];

			packages = [
				# Management
				"com.github.tchx84.Flatseal"
				"io.github.giantpinkrobots.flatsweep"
				"io.podman_desktop.PodmanDesktop"
				"io.github.dvlv.boxbuddyrs"
			];
		};

		# Gnome compatibility
		dconf = {
			enable = true;
			settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
		};
	};
}
