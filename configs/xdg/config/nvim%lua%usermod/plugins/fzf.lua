-- Binary dependencies: bat, fd, fzf, ripgrep
return {
	{
		'ibhagwan/fzf-lua',
		opts = { 'fzf-native' },
		keys = {
			{ '<leader>rg', function() require('fzf-lua').files({}) end, desc = "Fuzzy find files" },
			{ '<leader>rr', function() require('fzf-lua').live_grep({ resume = true }) end, desc = "Search project" },
			{ '<leader>rR', function() require('fzf-lua').live_grep({ resume = false }) end, desc = "Search project (clean)" },
		},
	},
}
