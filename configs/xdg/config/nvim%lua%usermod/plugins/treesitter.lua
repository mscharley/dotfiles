return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VimEnter',
		run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'yaml', 'json', 'json5', 'markdown', 'toml',
					'lua', 'vim', 'vimdoc',
					'graphql',
					'perl',
					'javascript', 'typescript', 'tsx',
					'gleam', 'rust',
				},
				highlight = { enable = true },
			})

			vim.filetype.add({
				extension = {
					mdx = 'mdx',
				},
			})

			vim.treesitter.language.register('markdown', 'mdx')
		end
	},
	{
		-- This needs to not be lazy as it needs to be loaded before a file is loaded
		'fladson/vim-kitty',
		ft = 'kitty',
		version = '*',
	},
}
