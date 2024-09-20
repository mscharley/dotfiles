require('usermod.vimplug')('junegunn/fzf', {
	run = function()
		vim.fn["fzf#install"]()
	end
})
require('usermod.vimplug')('junegunn/fzf.vim', {
	config = function()
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		map('n', '<Leader>f', '<Cmd>Files<CR>', opts)
		map('n', '<Leader>g', '<Cmd>GFiles<CR>', opts)
	end
})
