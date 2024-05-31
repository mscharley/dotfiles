require('usermod.vimplug')('https://git.sr.ht/~whynothugo/lsp_lines.nvim', {
	as = "lsp_lines",
	config = function()
		require('lsp_lines').setup()
	end
})

