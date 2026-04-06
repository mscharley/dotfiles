{ lib, pkgs, ... }: let
	inherit (lib.generators) mkLuaInline;
	inherit (lib.nvim.lua) toLuaObject;
in {
	vim = {
		extraPlugins.spellwarn = let
			setupOpts = {
				enable = false;
				severity = {
					spellbad   = "WARN";
					spellrare  = "HINT";
					spellcap   = "HINT";
					spelllocal = "HINT";
				};
			};
		in {
			package = pkgs.vimPlugins.spellwarn-nvim;
			setup = "require('spellwarn').setup(${toLuaObject setupOpts})";
		};
		keymaps = [
			{
				desc = "Toggle spelling warnings";
				key = "<leader>ts";
				mode = "n";
				lua = true;
				action = "function() require('spellwarn').toggle() end";
			}
		];

		lsp = {
			enable = true;
			lspconfig.enable = true;
			formatOnSave = true;

			mappings = {
				addWorkspaceFolder = null;
				codeAction = "<leader>ff";
				documentHighlight = null;
				format = null;
				goToDeclaration = null;
				goToDefinition = "<leader>gi";
				goToType = null;
				hover = null; # TODO
				listDocumentSymbols = null;
				listImplementations = null;
				listReferences = "<leader>gr";
				listWorkspaceFolders = null;
				listWorkspaceSymbols = null;
				nextDiagnostic = "<leader>ge";
				openDiagnosticFloat = "<leader>e";
				previousDiagnostic = null;
				removeWorkspaceFolder = null;
				renameSymbol = "<leader>fn";
				signatureHelp = null;
				toggleFormatOnSave = null;
			};
		};

		diagnostics = {
			enable = true;
			config = {
				virtual_lines = {
					severity = {
						min = mkLuaInline "vim.diagnostic.severity.WARN";
					};
					current_line = false;
				};
			};
		};

		languages = {
			enableTreesitter = true;
			enableDAP = true;

			# Enable Nix support since we're clearly a nix user...
			nix.enable = true;

			# Markup file support
			html.enable = true;
			markdown.enable = true;
			tailwind.enable = true;

			# Full language support
			gleam.enable = true;
			lua.enable = true;
			lua.lsp.lazydev.enable = true;
			ruby.enable = true;
			rust.enable = true;
			ts.enable = true;

			# Shell script support
			bash.enable = true;
		};

		# Prefer using the enable option under languages if there is one available
		treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
			yaml json json5 toml
			fish
			vim vimdoc
			graphql
			css
			diff

			rescript
			perl
		];
	};
}
