vim.o.mousemoveevent = true

return {
	{
		'lewis6991/hover.nvim',
		event = 'BufReadPost',
		config = function()
			require('hover').setup({
				init = function()
					-- Require providers
					require('hover.providers.lsp')
					-- require('hover.providers.gh')
					-- require('hover.providers.gh_user')
					-- require('hover.providers.jira')
					-- require('hover.providers.dap')
					-- require('hover.providers.man')
					-- require('hover.providers.dictionary')
				end,
				mouse_providers = { 'LSP' },
				mouse_delay = 1000,
			})
		end,
		keys = {
			-- Hover keymaps
			{ 'K', function() require('hover').hover() end, desc = 'Display hover information' },
			{ 'gK', function() require('hover').hover_select() end, desc = 'hover.nvim (select)' },
			{ '<C-p>', function() require('hover').hover_switch('previous') end, desc = 'hover.nvim (previous source)' },
			{ '<C-n>', function() require('hover').hover_switch('next') end, desc = 'hover.nvim (next source)' },

			-- Mouse support for hover
			{ '<MouseMove>', function() require('hover').hover_mouse() end, mode = { 'n' }, desc = 'hover.nvim (mouse)' },
		},
	},
}
