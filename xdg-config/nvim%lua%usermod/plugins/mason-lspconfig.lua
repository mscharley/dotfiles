return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = { 'williamboman/mason.nvim' },
	event = "VimEnter",
	opts = {
		ensure_installed = { "eslint", "rust_analyzer", "lua_ls", "jsonls", "yamlls" },
	}
}
