{ pkgs, ... }:
{
	imports = [
		./fzf-lua.nix
		./nvim-tree.nix
		./ui.nix
	];

	vim = {
		# Disable default aliases until we have a valid configuration worth using
		viAlias = false;
		vimAlias = false;

		withNodeJs = true;
		extraPackages = with pkgs; [
			# LSP packages
			vscode-js-debug

			# Other helper utilities used by plugins
			ack bat fd fzf ripgrep
		];

		globals = {
			# Setup leader
			mapleader = " ";
			maplocalleader = "\\";
		};

		options = {
			# Enable mouse support
			mouse = "a";

			# Styling
			cursorline = true;
			textwidth = 120;
			wrapmargin = 0;
			colorcolumn = "121";
			number = true;
			relativenumber = true;
			numberwidth = 4;
			termguicolors = true;
			scrolloff = 5;
			showtabline = 2; # 2 = always

			# Folding options
			foldmethod = "marker";

			# Enable spell checking
			spell = true;
			spelllang = "en_au,cjk";

			# Tab/whitespace configuration
			# require('usermod.whitespace').hardtabs(4);
			list = true;

			# Backups
			backup = true;

			# Allow project-specific settings
			exrc = true;
			modelines = 20;
		};

		lsp.enable = true;
		languages = {
			enableTreesitter = true;

			# Enable Nix support since we're clearly a nix user...
			nix.enable = true;

			# Markup file support
			html.enable = true;
			markdown.enable = true;

			# Full language support
			gleam.enable = true;
			lua.enable = true;
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
			perl
			css
			diff
		];

		binds.whichKey.enable = true;
		git.enable = true;
	};
}
