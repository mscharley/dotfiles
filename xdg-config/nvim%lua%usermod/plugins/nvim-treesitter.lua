return {
	'nvim-treesitter/nvim-treesitter',
	run = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				"yaml", "json", "json5", "markdown", "toml",
				"lua", "vim", "vimdoc",
				"perl",
				"javascript", "typescript",
				"gleam", "rust"
			},
			highlight = { enable = true },
		})
	end
}
