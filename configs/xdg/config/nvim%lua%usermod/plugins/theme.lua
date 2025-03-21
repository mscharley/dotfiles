return {
	{
		'sainnhe/sonokai',
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_style = 'andromeda'
			vim.g.sonokai_better_performance = 1
		end,
	},
	{
		'rktjmp/lush.nvim',
		lazy = false,
	},
	{
		'zaldih/themery.nvim',
		lazy = false,
		version = "*",
		opts = {
			themes = {
				{
					name = 'Andromeda',
					colorscheme = 'sonokai',
					before = [[
						vim.g.sonokai_style = 'andromeda'
					]],
				},
				{
					name = 'Lush',
					colorscheme = 'lush',
				},
			},
		},
	}
}
