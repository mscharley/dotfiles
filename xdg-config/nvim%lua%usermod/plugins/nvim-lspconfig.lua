require('usermod.vimplug')('neovim/nvim-lspconfig', {
	config = function()
		-- Disable virtual_text since it's redundant due to lsp_lines.
		vim.diagnostic.config({
		  virtual_text = false,
		})

		local lspconfig = require('lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		lspconfig.eslint.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})
		lspconfig.gleam.setup({ capabilities = capabilities })
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })

		-- Autoformat code for LSP's that support it
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = {
				"*.gleam",
				"*.rs",
			},
			callback = function() vim.lsp.buf.format({}) end,
		})
	end
})

