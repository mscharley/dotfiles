-- Styling
vim.opt.cursorline = true
vim.opt.textwidth = 120
vim.opt.wrapmargin = 0
vim.opt.colorcolumn = '121'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.showtabline = 2 -- 2 = always

-- Folding options
vim.opt.foldmethod = 'marker'

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_au,cjk'

-- Tab/whitespace configuration
require('usermod.whitespace').hardtabs(4)
vim.opt.list = true

-- Backups
vim.opt.backup = true
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. '/nvim/backup'

-- Allow project-specific settings
vim.opt.exrc = true
vim.opt.modelines = 20

-- Make sure to set `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to set other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Run the lazy.nvim package manager
require('usermod.config.lazy')

-- Configure tab titles
require('usermod.title')

-- Load custom key bindings
require('usermod.keybindings')

-- Load custom file type configurations
require('usermod.filetypes')
