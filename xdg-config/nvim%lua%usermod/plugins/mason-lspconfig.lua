return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = { 'williamboman/mason.nvim' },
	opts = {
		ensure_installed = { "eslint", "rust_analyzer", "lua_ls", "jsonls", "yamlls" },
	}
}
