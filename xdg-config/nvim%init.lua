-- Load existing vim configuration
-- vim.cmd("source $XDG_CONFIG_HOME/vim/vimrc")

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Styling
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.showtabline = 2
vim.opt.title = true

-- Tab/whitespace configuration
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.listchars = 'tab:> ,leadmultispace:┃   ,trail:-,nbsp:+'
vim.opt.list = true

-- Backups
vim.opt.backup = true
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. "/nvim/backup"

-- Allow project-specific settings
vim.opt.exrc = true

-- Load vim-plug
local Plug = require('usermod.vimplug')

Plug.begin()

-- THEMING
require('usermod.themes.sonokai')
require('usermod.plugins.nvim-web-devicons')
require('usermod.themes.lush')

-- LIBRARIES
require('usermod.plugins.plenary')
require('usermod.plugins.mason')

-- PLUGINS (load order is important)
require('usermod.plugins.gitsigns')
require('usermod.plugins.barbar')
require('usermod.plugins.fzf')
require('usermod.plugins.nvim-cmp')
require('usermod.plugins.ollama')
require('usermod.plugins.schemastore')
require('usermod.plugins.mason-lspconfig')
require('usermod.plugins.nvim-lspconfig')
require('usermod.plugins.nvim-treesitter')
require('usermod.plugins.nvim-tree')
require('usermod.plugins.lsp_lines')
require('usermod.plugins.nvim-lsp-file-operations')
require('usermod.plugins.hover')
require('usermod.plugins.nvim-surround')
require('usermod.plugins.commentary')
require('usermod.plugins.lualine')

-- LANGUAGE TOOLS
require('usermod.plugins.typescript-tools')

Plug.ends()

require('usermod.keybindings')

