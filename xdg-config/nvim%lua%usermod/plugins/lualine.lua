-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
	local available = package.loaded["ollama"] and require("ollama").status ~= nil
	if not available then
		return "🦙⛔"
	else
		local status = require("ollama").status()

		if status == "IDLE" then
			return "🦙🟢"
		elseif status == "WORKING" then
			return "🦙🟡"
		end
	end
end

require('usermod.vimplug')('nvim-lualine/lualine.nvim', {
	config = function()
		require('lualine').setup({
			options = {
				icons_enabled = true,
				theme = require('lualine.themes.horizon'),
				component_separators = { left = '\u{e0bf}', right = '\u{e0bd}'},
				section_separators = { left = '\u{e0b8}', right = '\u{e0ba}'},
				globalstatus = true,
				ignore_focus = { "NvimTree", "help" },
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {get_status_icon, 'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			extensions = { "nvim-tree" },
		})
	end
})

