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
			extensions = { "nvim-tree" },
		})
	end
})

