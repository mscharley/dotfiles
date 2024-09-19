require('usermod.vimplug')('williamboman/mason.nvim', {
	config = function()
		require("mason").setup()
	end
})
