
return {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	name = "lsp_lines",
	event = "BufReadPre",
	config = function()
		-- Disable virtual_text since it's redundant due to lsp_lines.
		vim.diagnostic.config({
			virtual_text = false,
		})

		require("lsp_lines").setup({})
	end,
}
