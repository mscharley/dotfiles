local M = {}

function M.softtabs(n, localOnly)
	localOnly = localOnly == nil and false or localOnly
	local setter = localOnly and vim.opt_local or vim.opt
	setter.expandtab = true
	setter.tabstop = n
	setter.softtabstop = n
	setter.shiftwidth = n
	setter.listchars = 'tab:> ,leadmultispace:┃'..string.rep(' ', n - 1)..',trail:-,nbsp:+'
end

function M.hardtabs(n, localOnly)
	localOnly = localOnly == nil and false or localOnly
	local setter = localOnly and vim.opt_local or vim.opt
	setter.expandtab = false
	setter.tabstop = n
	setter.softtabstop = n
	setter.shiftwidth = n
	setter.listchars = 'tab:> ,leadmultispace: '..string.rep(' ', n - 1)..',trail:-,nbsp:+'
end

return M
