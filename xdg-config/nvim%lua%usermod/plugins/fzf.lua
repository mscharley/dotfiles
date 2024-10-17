-- Binary dependencies: fzf, bat, fd
return {
	{
		'ibhagwan/fzf-lua',
		opts = { 'fzf-native' },
		keys = {
			{ '<leader>g', function(...) require('fzf-lua').files(unpack(arg)) end, desc = "Fuzzy find files" },
			{ '<leader>r', function(...) require('fzf-lua').live_grep_resume(unpack(arg)) end, desc = "Search project" },
			{ '<leader>R', function(...) require('fzf-lua').live_grep(unpack(arg)) end, desc = "Search project (clean)" },
		},
	},
}
