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
		'neovim/nvim-lspconfig',
		version = '*',
		dependencies = { 'williamboman/mason-lspconfig.nvim' },
		event = "BufReadPost",
		config = function()
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
					}
				},
			})
			lspconfig.gleam.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = { Lua = {  } },
				on_init = function(client)
					-- Helper to load the VIM runtimes when editing lua files
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT'
						},
						diagnostics = {
							-- Get the language server to recognise the `vim` global
							globals = {
								'vim',
								'require',
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							-- library = {
							-- 	vim.env.VIMRUNTIME
							-- 	-- Depending on the usage, you might want to add additional paths here.
							-- 	-- "${3rd}/luv/library"
							-- 	-- "${3rd}/busted/library",
							-- }
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							library = vim.api.nvim_get_runtime_file("", true)
						}
					})
				end,
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
				'<leader>qf',
				function()
					vim.lsp.buf.code_action({
						filter = function(a) return a.isPreferred end,
						apply = true
					})
				end,
				desc = "Quick fix",
			},
			{ '<leader>ff', function() vim.lsp.buf.code_action() end, desc = "Show code fix menu" },

			-- Diagnostics
			{ '<leader>e', function() vim.diagnostic.open_float() end, desc = "Show error details" },
		},
	},
}
