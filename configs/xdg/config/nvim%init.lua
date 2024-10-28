-- Load existing vim configuration
-- vim.cmd("source $XDG_CONFIG_HOME/vim/vimrc")

-- Styling
vim.opt.cursorline = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.showtabline = 2
vim.opt.title = true

-- Tab/whitespace configuration
require('usermod.whitespace').hardtabs(4)
vim.opt.list = true

-- Backups
vim.opt.backup = true
vim.opt.backupdir = vim.env.XDG_DATA_HOME .. "/nvim/backup"

-- Allow project-specific settings
vim.opt.exrc = true

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Run the lazy.nvim package manager
require('usermod.config.lazy')

-- Load custom keybindings
require('usermod.keybindings')
