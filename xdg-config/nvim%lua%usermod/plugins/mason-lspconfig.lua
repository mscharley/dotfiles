require('usermod.vimplug')('williamboman/mason-lspconfig.nvim', {
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = { "eslint", "rust_analyzer", "lua_ls", "jsonls", "yamlls" },
		})
	end
})
