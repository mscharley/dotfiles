require('usermod.vimplug')('sainnhe/sonokai', {
	config = function()
		vim.g.sonokai_style = 'andromeda'
		vim.g.sonokai_better_performance = 1
		vim.cmd.colorscheme('sonokai')
	end
})

