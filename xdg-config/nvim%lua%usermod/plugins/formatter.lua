require('usermod.vimplug')('mhartington/formatter.nvim', {
	config = function()
		require('formatter').setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				['*'] = {
					require('formatter.defaults.prettier'),
				},
			},
		})
		vim.api.nvim_create_augroup("__formatter__", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWriteLock",
		})
	end
})
