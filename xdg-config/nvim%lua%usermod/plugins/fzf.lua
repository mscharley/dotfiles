# Binary dependencies: fzf, bat, fd
require('usermod.vimplug')('ibhagwan/fzf-lua', {
	branch = "main",
	config = function()
		require('fzf-lua').setup({ 'fzf-native' })
	end
})
