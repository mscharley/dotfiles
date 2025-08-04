-- Binary dependencies: bat, fd, fzf, ripgrep
return {
	{
		'ibhagwan/fzf-lua',
		opts = { 'fzf-native' },
		keys = {
			{ '<leader>g', function() require('fzf-lua').files({}) end, desc = "Fuzzy find files" },
			{ '<leader>r', function() require('fzf-lua').live_grep({ resume = true }) end, desc = "Search project" },
			{ '<leader>R', function() require('fzf-lua').live_grep({ resume = false }) end, desc = "Search project (clean)" },
		},
	},
}
