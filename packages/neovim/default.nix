{ pkgs, ... }:
{
	imports = [
		./fzf-lua.nix
	];

	config.vim = {
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

		options = {
			mouse = "a";
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

		git.enable = true;
	};
}
