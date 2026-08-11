{ lib, desktop, pkgs, ... }:
{
	config = lib.mkIf (desktop == "kde") {
		# rc2nix - nix run github:nix-community/plasma-manager
		programs.plasma = {
			enable = true;
			immutableByDefault = true;
			# Whether to force this as the only configuration
			# overrideConfig = true;

			workspace = {
				clickItemTo = "select";
				lookAndFeel = "org.kde.breezedark.desktop";
				iconTheme = "breeze-dark";
				cursor = {
					theme = "breeze_cursors";
					size = 30;
				};
			};

			fonts = let
				firaCode = { family = "Fira Code"; pointSize = 10; };
				notoSans = { family = "Noto Sans"; pointSize = 11; };
				notoSerif = notoSans // { family = "Noto Serif"; };
			in {
				general = lib.mkDefault notoSerif;
				fixedWidth = lib.mkDefault firaCode;
				small = lib.mkDefault (notoSerif // { pointSize = 8; });
				toolbar = lib.mkDefault notoSans;
				menu = lib.mkDefault notoSans;
				windowTitle = lib.mkDefault (notoSans // { pointSize = 12; });
			};

			configFile = {
				# Startup
				"ksmserverrc"."General"."loginMode" = "emptySession";
				"PlasmaUserFeedback"."Global"."FeedbackLevel" = 48;

				# Disable middle-click paste
				"kwinrc"."Wayland"."EnablePrimarySelection" = { value = false; immutable = false; };

				# Theming
				"kdeglobals"."General"."AccentColor" = "146,110,228";
				"plasma-localerc"."Formats"."LANG" = lib.mkDefault { value = "en_AU.UTF-8"; immutable = false; };
				"kdeglobals"."General"."XftAntialias" = lib.mkDefault { value = true; immutable = false; };
				"kdeglobals"."General"."XftSubPixel" = lib.mkDefault { value = "rgb"; immutable = false; };
				"kdeglobals"."General"."XftHintStyle" = lib.mkDefault { value = "hintslight"; immutable = false; };

				# Default apps
				"kdeglobals"."General"."TerminalApplication" = "kitty";
				"kdeglobals"."General"."TerminalService" = "kitty.desktop";

				# Night Light
				"kwinrc"."NightColor"."Active" = true;
				"kwinrc"."NightColor"."NightTemperature" = 4200;
				# Melbourne
				"kwinrc"."NightColor"."Mode" = "Location";
				"kwinrc"."NightColor"."LatitudeFixed" = "-37.814";
				"kwinrc"."NightColor"."LongitudeFixed" = "144.96332";

				# Setup fcitx
				"kwinrc"."Wayland"."InputMethod" = {
					value = "${pkgs.qt6Packages.fcitx5-with-addons}/share/applications/fcitx5-wayland-launcher.desktop";
					shellExpand = true;
				};
				"kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;

				# Don't save screenshots by default
				"spectaclerc"."General"."autoSaveImage" = false;
				"spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
				"spectaclerc"."General"."launchAction" = "DoNotTakeScreenshot";
			};
		};
	};
}
