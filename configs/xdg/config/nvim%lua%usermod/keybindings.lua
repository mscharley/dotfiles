-- Navigate by visual line instead of logical line
vim.keymap.set({'n'}, '<down>', 'gj')
vim.keymap.set({'n'}, '<up>', 'gk')

-- Move line up/down
vim.keymap.set({'n'}, '<A-up>', 'dd<up>P', { desc = "Move line up" })
vim.keymap.set({'n'}, '<A-down>', 'ddp', { desc = "Move line down" })

-- Navigate between split buffers
vim.keymap.set({'n'}, '<C-A-up>', '<C-w><up>')
vim.keymap.set({'n'}, '<C-A-down>', '<C-w><down>')
vim.keymap.set({'n'}, '<C-A-left>', '<C-w><left>')
vim.keymap.set({'n'}, '<C-A-right>', '<C-w><right>')

-- Split buffers
vim.keymap.set({'n'}, '<leader>"', "<Cmd>vsplit<CR>", { desc = 'Split screen (vertical)' })
vim.keymap.set({'n'}, '<leader>%', "<Cmd>split<CR>", { desc = 'Split screen (horizontal)' })

-- Move to previous/next tab
vim.keymap.set({'n'}, '<A-,>', '<Cmd>BufferPrevious<CR>', { desc = 'View buffer left' })
vim.keymap.set({'n'}, '<A-.>', '<Cmd>BufferNext<CR>', { desc = 'View buffer right' })

-- Re-order to previous/next tab
vim.keymap.set({'n'}, '<D-A-,>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
vim.keymap.set({'n'}, '<D-A-.>', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })

-- -- Goto buffer in position...
-- vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
-- vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
-- vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
-- vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
-- vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
-- vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
-- vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
-- vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
-- vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
-- vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')

-- Pin/unpin buffer
-- vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>')

-- Close buffer
vim.keymap.set({'n'}, '<A-q>', '<Cmd>BufferClose<CR>', { desc = 'Close buffer' })

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
-- map('n', '<C-p>', '<Cmd>BufferPick<CR>')

-- Sort automatically by...
-- vim.keymap.set('n', '<Leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
-- vim.keymap.set('n', '<Leader>bn', '<Cmd>BufferOrderByName<CR>')
-- vim.keymap.set('n', '<Leader>bd', '<Cmd>BufferOrderByDirectory<CR>')
-- vim.keymap.set('n', '<Leader>bl', '<Cmd>BufferOrderByLanguage<CR>')
-- vim.keymap.set('n', '<Leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>')
