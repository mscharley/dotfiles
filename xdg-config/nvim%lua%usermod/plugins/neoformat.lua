require('usermod.vimplug')('sbdchd/neoformat', {
	config = function()
		vim.g.neoformat_try_node_exe = 1

		local fmt = vim.api.nvim_create_augroup("fmt", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
			group = fmt,
			pattern = {"*.md", "*.markdown", "*.json", "*.yml", "*.yaml"},
			command = "Neoformat",
		})
	end
})

