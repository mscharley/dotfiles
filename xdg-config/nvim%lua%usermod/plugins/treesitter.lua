return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = "VimEnter",
		run = ":TSUpdate",
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					"yaml", "json", "json5", "markdown", "toml",
					"lua", "vim", "vimdoc",
					"graphql",
					"perl",
					"javascript", "typescript",
					"gleam", "rust",
				},
				highlight = { enable = true },
			})
		end
	},
}
