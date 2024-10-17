return {
	{
		'mhartington/formatter.nvim',
		event = 'BufReadPost',
		config = function()
			local formatters = {}
			local prettierrc = vim.fs.find('.prettierrc', { path = "./", type = "file", upward = true })
			if #prettierrc > 0 then
				table.insert(formatters, require('formatter.defaults.prettier'))
			end

			require('formatter').setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					['*'] = formatters,
				},
			})
			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWriteLock",
			})
		end,
	},
}
