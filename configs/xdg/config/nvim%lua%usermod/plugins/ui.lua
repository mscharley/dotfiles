vim.g.barbar_auto_setup = false

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

return {
	{
		'Shatur/neovim-session-manager',
		config = function()
			local config = require('session_manager.config')
			local session_manager = require('session_manager')
			session_manager.setup({
				autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
				autosave_only_in_session = true,
			})
		end,
	},
	{
		'goolord/alpha-nvim',
		dependencies = { 'Shatur/neovim-session-manager', 'nvim-tree/nvim-web-devicons' },
		config = function ()
			local theme = require('usermod.theme.alpha');
			theme.file_icons.provider = 'devicons'
			require('alpha').setup(theme.config)
		end
	},
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		init = function() vim.g.barbar_auto_setup = false end,
		version = "*",
		opts = {
			exclude_ft = { 'gitcommit' },
			highlight_visible = false,
			icons = {
				gitsigns = {
					added = {enabled = true, icon = '+'},
					changed = {enabled = true, icon = '~'},
					deleted = {enabled = true, icon = '-'},
				},
				preset = 'slanted',
			},
		},
	},
	{
		'nvim-lualine/lualine.nvim',
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
	},
}
