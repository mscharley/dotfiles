return {
	{
		'tpope/vim-commentary',
		event = 'VimEnter',
		config = function()
		end
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VimEnter',
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		version = '*',
		event = "VimEnter",
		opts = {
			numhl = true,
		}
	},
}
