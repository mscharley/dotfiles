local M = {}

function M.softtabs(n)
	vim.opt.expandtab = true
	vim.opt.tabstop = n
	vim.opt.softtabstop = n
	vim.opt.shiftwidth = n
	vim.opt.listchars = 'tab:> ,leadmultispace:┃'..string.rep(' ', n - 1)..',trail:-,nbsp:+'
end

return M
