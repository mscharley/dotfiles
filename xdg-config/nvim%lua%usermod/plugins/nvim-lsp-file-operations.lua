require('usermod.vimplug')('antosha417/nvim-lsp-file-operations', {
	config = function()
		require("lsp-file-operations").setup({})
	end
})

