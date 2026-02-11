
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
		version = "*",
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			exclude_ft = { 'gitcommit' },
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
		'andrewferrier/wrapping.nvim',
		config = function()
			require('wrapping').setup {
				create_keymaps = false,
			}
		end,
		keys = {
			{ "[ow", function() require('wrapping').soft_wrap_mode() end, silent = true, desc = 'Switch to soft wrapping mode' },
			{ "]ow", function() require('wrapping').hard_wrap_mode() end, silent = true, desc = 'Switch to hard wrapping mode' },
			{ "<leader>ow", function() require('wrapping').toggle_wrap_mode() end, silent = true, desc = 'Toggle wrapping mode' },
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'sainnhe/sonokai',
			'andrewferrier/wrapping.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = require'usermod.theme.lualine',
					component_separators = { left = '\u{e0bf}', right = '\u{e0bd}' },
					section_separators = { left = '\u{e0b8}', right = '\u{e0ba}' },
					globalstatus = true,
					ignore_focus = { 'help' },
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff' },
					lualine_c = { 'lsp_status', 'filename', 'diagnostics' },
					lualine_x = { 'encoding', require('usermod.lualine.fileformat'), 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' }
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = { 'location' },
					lualine_y = {},
					lualine_z = {}
				},
				extensions = { 'fzf', 'lazy', 'nvim-tree' },
			}
		end,
	},
}
