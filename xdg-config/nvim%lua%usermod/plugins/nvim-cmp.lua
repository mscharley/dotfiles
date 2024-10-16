return {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name ='nvim_lsp' },
				}),
			})
		end
	}
}
