return {
	{
		'mfussenegger/nvim-dap',
		event = 'BufReadPost',
		config = function()
		end,
		keys = {
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ '<leader>dd', function() require('dap').continue() end, desc = "Start or resume a debugging session" },
			{ '<leader>dr', function() require('dap').repl.open() end, desc = "Show debugging REPL" },
		},
	},
}
