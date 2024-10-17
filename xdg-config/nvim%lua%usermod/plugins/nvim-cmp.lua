vim.g.vsnip_snippet_dir = vim.fn.stdpath("data") .. "/vsnip"
vim.g.vsnip_filetypes = {
	javascriptreact = { "javascript" },
	typescriptreact = { "typescript" },
}

return {
	{ 'hrsh7th/cmp-buffer', lazy = true },
	{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
	{
		'hrsh7th/vim-vsnip',
		lazy = true,
		config = function()
			-- Expand
			vim.keymap.set({ 'i', 's' }, '<C-j>', function()
				if vim.fn['vsnip#expandable']() ~= 0 then
					return '<Plug>(vsnip-expand)'
				else
					return '<C-j>'
				end
			end, { expr = true })

			-- Expand or jump
			vim.keymap.set({ 'i', 's' }, '<C-l>', function()
				if vim.fn['vsnip#available'](1) ~= 0 then
					return '<Plug>(vsnip-expand-or-jump)'
				else
					return '<C-l>'
				end
			end, { expr = true })

			-- Jump forward or backward
			vim.keymap.set({ 'i', 's' }, '<Tab>', function()
				if vim.fn['vsnip#jumpable'](1) ~= 0 then
					return '<Plug>(vsnip-jump-next)'
				else
					return '<Tab>'
				end
			end, { expr = true })
			vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
				if vim.fn['vsnip#jumpable'](-1) ~= 0 then
					return '<Plug>(vsnip-jump-prev)'
				else
					return '<Tab>'
				end
			end, { expr = true })
		end
	},
	{ 'hrsh7th/cmp-vsnip', lazy = true, dependencies = { 'hrsh7th/vim-vsnip' } },
	{
		'hrsh7th/nvim-cmp',
		event = "InsertEnter",
		-- Force these to be loaded along with cmp
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-vsnip',
		},
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn['vsnip#anonymous'](args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
				}, {
					{ name = 'buffer' },
				}),
			})
		end
	}
}
