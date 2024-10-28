vim.opt.title = true
vim.opt.titlestring = '%{luaeval("require(\'usermod.title\').generate()")}'

local M = {}

function M.generate()
	local filename = vim.fn.expand('%:~:.:p')
	local project = vim.fs.basename(vim.fn.getcwd()) .. ":"

	-- If this is a git file then display it verbatim, for commit messages and the like
	if filename:sub(0, 5) == ".git/" then
		project = ""
		filename = vim.fs.basename(filename)
	-- Don't force load plenary early
	elseif package.loaded['plenary'] or package.loaded['plenary.path'] then
		local path = require('plenary.path')
		filename = path.new(filename):shorten(1, { -1 })
	end

	return "nvim: " .. project .. filename
end

return M
