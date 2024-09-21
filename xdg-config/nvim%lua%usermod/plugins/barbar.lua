vim.g.barbar_auto_setup = false

require('usermod.vimplug')('romgrk/barbar.nvim', {
	config = function()
		require('barbar').setup({})
	end
})
