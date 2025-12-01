local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
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
				vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
				vim.keymap.set('n', '<Esc>', function() require('nvim-tree.api').tree.toggle() end, opts('Close'))

				-- Automatically open file on creation
				api.events.subscribe(api.events.Event.FileCreated, function(file)
					vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
				end)
			end,
			view = {
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

						return {
							border = 'rounded',
							relative = 'editor',
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			git = {
				enable = true,
			},
			filters = {
				git_ignored = false,
				git_clean = false,
				custom = {
					"^\\.git$",
					"^\\.turbo$",
					"^\\.direnv$",
					"^node_modules$"
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
				enable = true,
				truncate = true,
				types = {
					all = false,
					config = true,
					copy_paste = false,
					diagnostics = false,
					git = true,
					profile = false,
				},
			},
			renderer = {
				highlight_opened_files = "name",
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
					web_devicons = {
						file = { enable = true },
						folder = { enable = false },
					},
					glyphs = {
						git = {
							-- don't call out staged changes explicitly
							staged = " ",
							unstaged = "✗",
							unmerged = " ",
							renamed = " ",
							untracked = " ",
							deleted = " ",
							ignored = " ",
						},
					},
				},
			},
		},
		keys = {
			{ "<leader>s", function() require('nvim-tree.api').tree.toggle{ find_file = true } end, silent = true, desc = 'Toggle file tree and show current file' },
			{ "<leader>S", function() require('nvim-tree.api').tree.toggle{} end, silent = true, desc = 'Toggle file tree' },
		},
	},
}
