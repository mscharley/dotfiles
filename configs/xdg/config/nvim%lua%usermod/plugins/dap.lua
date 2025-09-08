return {
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap = require("dap")

			if vim.fn.executable("js-debug") == 1 then
				-- Nix or anything else that packages a js-debug wrapper for running the dap provider using node
				dap.adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						-- This is the wrapper executable that Nix installs, equivalent to `node dapDebugServer.js`
						command = "js-debug",
						args = {"${port}"},
					}
				}
			elseif vim.fn.isdirectory(vim.fn.expand("$HOME/opt/js-debug")) == 1 then
				-- Manually installed vscode-js-debug from https://github.com/microsoft/vscode-js-debug/releases
				require('dap').adapters['pwa-node'] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = { vim.fn.expand("$HOME/opt/js-debug/src/dapDebugServer.js"), "${port}" },
					},
				}
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
		keys = {
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ '<F6>', function() require('dap').toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ '<leader>dd', function() require('dap').continue() end, desc = "Start or resume a debugging session" },
			{ '<F5>', function() require('dap').continue() end, desc = "Start or resume a debugging session" },
			{ '<leader>do', function() require('dapui').open() end, desc = "Open the debugging UI" },
			{ '<leader>dq', function() require('dapui').close() end, desc = "Close the debugging UI" },
			{ '<F10>', function() require('dap').step_over() end, desc = "Debugging: Step over" },
			{ '<F11>', function() require('dap').step_into() end, desc = "Debugging: Step into" },
			{ '<F12>', function() require('dap').step_out() end, desc = "Debugging: Step out" },
			{ mode = { 'n', 'v' }, '<leader>dh', function() require('dap.ui.widgets').hover() end, desc = "DAP: hover" },
			{ mode = { 'n', 'v' }, '<leader>dp', function() require('dap.ui.widgets').preview() end, desc = "DAP: preview" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end

			dapui.setup{}
		end,
	},
}
