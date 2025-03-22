return {
	{
		'tpope/vim-commentary',
		event = 'BufReadPost',
		config = function()
		end
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'BufReadPost',
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		version = '*',
		event = "BufReadPost",
		opts = {
			numhl = true,
		}
	},
}
