return {
	{
		'tpope/vim-commentary',
		event = 'BufReadPost',
		config = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = {
					'gleam',
				},
				command = 'setlocal commentstring =//\\ %s',
			})
		end
	},
	{
		'kylechui/nvim-surround',
		event = 'BufReadPost',
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		opts = {
			numhl = true,
		}
	},
}
