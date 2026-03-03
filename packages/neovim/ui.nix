{ lib, pkgs, ... }: let
	inherit (lib.generators) mkLuaInline;
	inherit (lib.nvim.lua) toLuaObject;
in {
	imports = [
		./theme.nix
	];

	vim = {
		dashboard.alpha = {
			enable = true;
		};
		# Hack alpha with our custom theme
		pluginRC.alpha = lib.mkForce "require('alpha').setup(require('theme.alpha').config)";

		git.gitsigns = {
			enable = true;
			setupOpts = {
				numhl = true;
			};
		};

		globals.barbar_auto_setup = false;
		extraPlugins.barbar = let
			setupOpts = {
				exclude_ft = [ "gitcommit" ];
				icons = {
					gitsigns = {
						added = { enabled = true; icon = "+"; };
						changed = { enabled = true; icon = "~"; };
						deleted = { enabled = true; icon = "-"; };
					};
					preset = "slanted";
				};
			};
		in {
			package = pkgs.vimPlugins.barbar-nvim;
			setup = "require('barbar').setup(${toLuaObject setupOpts})";
		};

		session.nvim-session-manager = {
			enable = true;
			setupOpts = {
				autoload_mode = mkLuaInline '' { sm.AutoloadMode.GitSession, sm.AutoloadMode.CurrentDir } '';
				autosave_only_in_session = true;
			};
		};

		statusline.lualine = {
			enable = true;
			icons.enable = true;
			componentSeparator = { left = ""; right = ""; };
			sectionSeparator = { left = ""; right = ""; };
			globalStatus = true;
			ignoreFocus = [ "help" ];

			activeSection = {
				a = [ "'mode'" ];
				b = [ "'branch'" "'diff'" ];
				c = [ "'lsp_status'" "'filename'" "'diagnostics'" ];
				x = [ "'encoding'" /* "require('usermod.lualine.fileformat')" */ "'filetype'" ];
				y = [ "'progress'" ];
				z = [ "'location'" ];
			};

			inactiveSection = {
				a = [];
				b = [];
				c = [ "'filename'" ];
				x = [ "'location'" ];
				y = [];
				z = [];
			};
		};
	};
}
