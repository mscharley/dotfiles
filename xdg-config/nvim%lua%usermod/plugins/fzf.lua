require('usermod.vimplug')('junegunn/fzf', {
	run = function()
		vim.fn["fzf#install"]()
	end
})
require('usermod.vimplug')('junegunn/fzf.vim', {
	config = function()
	end
})
