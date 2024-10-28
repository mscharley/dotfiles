return {
	{
		'mhartington/formatter.nvim',
		event = 'BufReadPost',
		config = function()
			local prettier = {}
			local prettierrc = vim.fs.find('.prettierrc', { path = "./", type = "file", upward = true })
			if #prettierrc > 0 then
				table.insert(prettier, require('formatter.defaults.prettier'))
			end

			require('formatter').setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					css = prettier,
					graphql = prettier,
					json = prettier,
					markdown = prettier,
					yaml = prettier,
				},
			})
			vim.api.nvim_create_augroup("__formatter__", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = "__formatter__",
				command = ":FormatWriteLock",
			})
			-- Attempt to work around monorepos with node_modules at multiple levels and prettier installed in the root
			vim.api.nvim_create_autocmd("BufEnter", {
				group = "__formatter__",
				callback = function()
					if vim.fn.filereadable("./node_modules/.bin/prettier") == 1 then
						vim.b.formatter_node_modules = "./node_modules"
					end
				end,
			})
		end,
	},
}
