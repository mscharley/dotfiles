local uname = vim.fn.system({ "uname" })
local osx = uname == 'Darwin\n'

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			icons = {
				keys = {
					Up = " ",
					Down = " ",
					Left = " ",
					Right = " ",
					C = osx and "󰘴 " or "Ctrl ",
					M = osx and "󰘵 " or "Alt ",
					D = osx and "󰘳 " or "Super ",
					S = osx and "󰘶 " or "Shift ",
					CR = "󰌑 ",
					Esc = "󱊷 ",
					ScrollWheelDown = "󱕐 ",
					ScrollWheelUp = "󱕑 ",
					NL = "󰌑 ",
					BS = "󰁮",
					Space = "󱁐 ",
					Tab = "󰌒 ",
					F1 = "󱊫",
					F2 = "󱊬",
					F3 = "󱊭",
					F4 = "󱊮",
					F5 = "󱊯",
					F6 = "󱊰",
					F7 = "󱊱",
					F8 = "󱊲",
					F9 = "󱊳",
					F10 = "󱊴",
					F11 = "󱊵",
					F12 = "󱊶",
				}
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = true })
				end,
				desc = "Keymaps (which-key)",
			},
		},
	},
}
