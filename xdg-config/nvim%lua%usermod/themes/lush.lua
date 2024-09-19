require('usermod.vimplug')('rktjmp/lush.nvim', {
	config = function()
		vim.opt.background = 'dark'
		vim.g.colors_name = 'usermod.themes.lush-theme'

		package.loaded['usermod.themes.lush-theme'] = nil
		-- require('lush')(require('usermod.themes.lush-theme'))
	end
})

