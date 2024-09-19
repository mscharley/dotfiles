require('usermod.vimplug')('nvim-tree/nvim-tree.lua', {
	config = function()
		require("nvim-tree").setup({
			auto_reload_on_write = true,
			on_attach = function(bufnr)
				local api = require('nvim-tree.api')
				local function opts(desc)
					return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Attach all the default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- Remove unwanted mappings
				vim.keymap.del('n', '<C-]>', { buffer = bufnr })
				vim.keymap.del('n', 'g?',    { buffer = bufnr })
				vim.keymap.del('n', 's',     { buffer = bufnr })

				-- Add our own mappings
				vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))

				-- Automatically open file on creation
				api.events.subscribe(api.events.Event.FileCreated, function(file)
					vim.cmd("edit " .. file.fname)
				end)
			end,
			view = {
				width = 30,
			},
			git = {
				enable = true,
			},
			filters = {
				git_ignored = false,
				git_clean = false,
				custom = {
					"^.git$",
					"^.turbo$",
					"node_modules$"
				}
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					diagnostics = false,
					git = false,
					profile = false,
				},
			},
			renderer = {
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "┖",
						edge = "┃",
						item = "┠",
						bottom = "─",
						none = " ",
					}
				},
				icons = {
					git_placement = "after",
					glyphs = {
						git = {
							-- don't call out staged changes explicitly
							staged = "",
							unstaged = "✗",
							unmerged = "\u{f4db}",
							renamed = "\u{f45a}",
							untracked = "\u{f4dd}",
							deleted = "\u{f4dc}",
							ignored = "\u{e668}",
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<space>s", require('nvim-tree.api').tree.toggle, { silent = true, desc = 'toggle nvim-tree' })
	end
})

