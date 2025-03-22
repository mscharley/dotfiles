vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = { '*' },
	callback = function()
		(vim.hl or vim.highlight).on_yank {
			timeout=200,
		}
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'gitcommit' },
	callback = function()
		vim.opt_local.colorcolumn = "73"
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'gleam' },
	callback = function()
		-- Gleams built-in formatter insists on soft tabs
		require('usermod.whitespace').softtabs(2, true)
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help' },
	callback = function()
		vim.opt_local.colorcolumn = ""
		vim.opt_local.spell = false
	end
})
