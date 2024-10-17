-- Navigate by visual line instead of logical line
vim.keymap.set("", "<down>", "gj")
vim.keymap.set("", "<up>", "gk")

-- Move line up/down
vim.keymap.set("n", "<A-up>", "dd<up>P", { desc = "Move line up" })
vim.keymap.set("n", "<A-down>", "ddp", { desc = "Move line down" })

-- Navigate between split buffers
vim.keymap.set("n", "<C-A-up>", "<C-w><up>")
vim.keymap.set("n", "<C-A-down>", "<C-w><down>")
vim.keymap.set("n", "<C-A-left>", "<C-w><left>")
vim.keymap.set("n", "<C-A-right>", "<C-w><right>")

-- Split buffers
vim.keymap.set("n", "<leader>\"", "<Cmd>vsplit<CR>", { desc = "Split screen (vertical)" })
vim.keymap.set("n", "<leader>%", "<Cmd>split<CR>", { desc = "Split screen (horizontal)" })

-- Move to previous/next tab
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')

-- Re-order to previous/next tab
vim.keymap.set('n', '<D-A-,>', '<Cmd>BufferMovePrevious<CR>')
vim.keymap.set('n', '<D-A-.>', '<Cmd>BufferMoveNext<CR>')

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
vim.keymap.set('n', '<A-q>', '<Cmd>BufferClose<CR>')

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
-- vim.keymap.set('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
-- vim.keymap.set('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>')
-- vim.keymap.set('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
-- vim.keymap.set('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
-- vim.keymap.set('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

-- Hover keymaps
vim.keymap.set("n", "K", require("hover").hover, { desc = "Display hover information" })
vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, { desc = "hover.nvim (previous source)" })
vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, { desc = "hover.nvim (next source)" })

-- Mouse support for hover
vim.keymap.set({ 'n', 'i' }, '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
vim.o.mousemoveevent = true

-- Tree keybindings
vim.keymap.set("n", "<leader>s", require('nvim-tree.api').tree.toggle, { silent = true, desc = 'toggle nvim-tree' })

-- Fuzzy file finder
vim.keymap.set('n', '<leader>g', require('fzf-lua').files, { desc = "Fuzzy find files" })
vim.keymap.set('n', '<leader>r', require('fzf-lua').live_grep_resume, { desc = "Search project" })
vim.keymap.set('n', '<leader>R', require('fzf-lua').live_grep, { desc = "Search project (clean)" })

-- LSP interactions
local function quickfix()
	vim.lsp.buf.code_action({
		filter = function(a) return a.isPreferred end,
		apply = true
	})
end
vim.keymap.set('n', '<leader>qf', quickfix, { desc = "Quick fix" })
vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.code_action() end, { desc = "Show code fix menu" })
