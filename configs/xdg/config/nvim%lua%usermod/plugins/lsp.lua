return {
	{
		'b0o/schemastore.nvim',
		lazy = true,
	},
	{
		'pmizio/typescript-tools.nvim',
		event = 'BufReadPost',
		opts = {},
	},
	{
		'williamboman/mason.nvim',
		version = '*',
		lazy = true,
		opts = {},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		version = '*',
		dependencies = { 'williamboman/mason.nvim' },
		event = 'VimEnter',
		opts = {
			ensure_installed = { 'eslint', 'rust_analyzer', 'lua_ls', 'jsonls', 'yamlls' },
		}
	},
	{
		'antosha417/nvim-lsp-file-operations',
		event = 'BufReadPost',
		opts = {},
	},
	{
		'ravibrock/spellwarn.nvim',
		event = 'VeryLazy',
		dependencies = {},
		opts = {
			enable = false,
			severity = {
				spellbad   = "HINT",
				spellrare  = "HINT",
				spellcap   = "HINT",
				spelllocal = "HINT",
			},
		},
		keys = {
			{ '<leader>ts', function() require('spellwarn').toggle() end, desc = "Toggle spelling warnings" },
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Library paths can be absolute
				-- "~/projects/my-awesome-lib",
				-- Or relative, which means they will be resolved from the plugin dir.
				"lazy.nvim",
				-- It can also be a table with trigger words / mods
				-- Only load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				-- always load the LazyVim library
				"LazyVim",
				-- Only load the lazyvim library when the `LazyVim` global is found
				{ path = "LazyVim", words = { "LazyVim" } },
				-- Load the wezterm types when the `wezterm` module is required
				-- Needs `justinsgithub/wezterm-types` to be installed
				-- { path = "wezterm-types", mods = { "wezterm" } },
				-- Load the xmake types when opening file named `xmake.lua`
				-- Needs `LelouchHe/xmake-luals-addon` to be installed
				-- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
			},
			enabled = function(root_dir)
				-- This is slightly different to the default, where it will be enabled by default
				return vim.g.lazydev_enabled == nil and false or vim.g.lazydev_enabled
			end,
		},
	},
	{
		'neovim/nvim-lspconfig',
		version = '*',
		dependencies = { 'williamboman/mason-lspconfig.nvim' },
		event = 'BufReadPost',
		config = function()
			-- Strip out some default keybindings
			vim.keymap.del('n', 'gra')
			vim.keymap.del('n', 'gri')
			vim.keymap.del('n', 'grn')
			vim.keymap.del('n', 'grr')

			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local flatEslint = vim.fs.find('eslint.config.js', { path = "./", type = "file", upward = true })

			vim.diagnostic.config({
				virtual_lines = {
					severity = { min = vim.diagnostic.severity.WARN },
					current_line = false,
				},
			})

			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
			vim.lsp.config.eslint.filetypes = {
				'javascript',
				'javascriptreact',
				'javascript.jsx',
				'typescript',
				'typescriptreact',
				'typescript.tsx',
				'graphql',
				'vue',
				'svelte',
				'astro',
				'htmlangular',
			}
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					experimental = { useFlatConfig = #flatEslint > 0 },
					rulesCustomizations = {
						{ rule = "@stylistic/*", fixable = true, severity = "off" },
						{ rule = "prettier/prettier", fixable = true, severity = "off" },
					},
				},
			})
			lspconfig.gleam.setup({ capabilities = capabilities })
			lspconfig.nixd.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			})
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				settings = {
					json = {
						schemas = require('schemastore').json.schemas(),
						validate = { enable = true },
					}
				}
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require('schemastore').yaml.schemas(),
					}
				}
			})

			-- Autoformat code for LSP's that support it
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = {
					"*.gleam",
					"*.rs",
				},
				callback = function() vim.lsp.buf.format({}) end,
			})
		end,
		keys = {
			-- LSP interactions
			{
				'<leader>fq',
				function()
					vim.lsp.buf.code_action({
						filter = function(a) return a.isPreferred end,
						apply = true
					})
				end,
				desc = "Quick fix",
			},
			{ '<leader>ff', function() vim.lsp.buf.code_action() end, desc = "Show code fix menu" },
			{ '<leader>gi', function() vim.lsp.buf.implementation() end, desc = "Jump to implementation" },
			{ '<leader>gr', function() vim.lsp.buf.references() end, desc = "Show all references" },
			{ '<leader>fn', function() vim.lsp.buf.rename() end, desc = "Rename" },

			-- Diagnostics
			{ '<leader>e', function() vim.diagnostic.open_float() end, desc = "Show error details" },
		},
	},
}
