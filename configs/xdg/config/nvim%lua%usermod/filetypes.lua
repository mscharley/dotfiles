local whitespace = require('usermod.whitespace')

vim.api.nvim_create_autocmd('TextYankPost', {
	pattern = { '*' },
	callback = function()
		(vim.hl or vim.highlight).on_yank {
			timeout=200,
		}
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'gitcommit' },
	callback = function()
		vim.opt_local.colorcolumn = "73"
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'gleam' },
	callback = function()
		-- Gleams built-in formatter insists on soft tabs
		whitespace.softtabs(2, true)
		vim.opt_local.colorcolumn = "81"
		vim.opt_local.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'help' },
	callback = function()
		vim.opt_local.colorcolumn = ""
		vim.opt_local.spell = false
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'rust' },
	callback = function()
		whitespace.hardtabs(4, true)
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'yaml' },
	callback = function()
		-- YAML doesn't work with hard tabs
		whitespace.softtabs(2, true)
	end,
})
