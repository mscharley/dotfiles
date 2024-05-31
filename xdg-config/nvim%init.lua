-- Load existing vim configuration
-- vim.cmd("source $XDG_CONFIG_HOME/vim/vimrc")

-- Disable newrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Styling
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.showtabline = 2
vim.opt.title = true

-- Tab configuration
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Backups
vim.opt.backup = true
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. "/nvim/backup"

-- Navigate by visual line instead of logical line
vim.keymap.set("", "<up>", "gk")
vim.keymap.set("", "<down>", "gj")

-- Load vim-plug
local Plug = require('usermod.vimplug')

Plug.begin()

-- THEMING
require('usermod.themes.sonokai')
require('usermod.plugins.nvim-web-devicons')

-- PLUGINS (load order is important)
require('usermod.plugins.gitsigns')
require('usermod.plugins.lualine')
require('usermod.plugins.barbar')
require('usermod.plugins.nvim-cmp')
require('usermod.plugins.nvim-lspconfig')
require('usermod.plugins.nvim-treesitter')
require('usermod.plugins.nvim-tree')
require('usermod.plugins.lsp_lines')

require('usermod.plugins.hover')
require('usermod.plugins.nvim-surround')
require('usermod.plugins.commentary')

Plug.ends()

local function vim_enter(data)
	local tree = require("nvim-tree.api").tree

	-- buffer is a real file on the disk
	local real_file = vim.fn.filereadable(data.file) == 1

	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	if real_file or no_name then
		local code_len = string.len(vim.env.CODE_HOME)
		if string.sub(data.file, 1, code_len) == vim.env.CODE_HOME then
			local first_sep = string.find(data.file, "/", code_len + 2)
			local root_end = first_sep and string.find(data.file, "/", first_sep + 1) or code_len
			local root = string.sub(data.file, 1, root_end)
			vim.cmd.cd(root)

			if not data.file:match("/%.git/") then
				-- open the tree, find the file but don't focus it
				tree.toggle({ focus = false, find_file = true, path = root })
			end
		else
			-- open the tree, find the file but don't focus it
			tree.toggle({ focus = false, find_file = true })
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = vim_enter })

