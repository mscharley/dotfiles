-- Initial revision lifted from https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom

local configs = {
	lazy = {},
	start = {}
}

local Plug = {
	begin = vim.fn['plug#begin'],

	-- "end" is a keyword, need something else
	ends = function()
		vim.fn['plug#end']()

		for i, config in pairs(configs.start) do
			config()
		end
	end
}

local apply_config = function(plugin_name)
	local fn = configs.lazy[plugin_name]
	if type(fn) == 'function' then fn() end
end

local plug_name = function(repo)
	return repo:match("^[%w-]+/([%w-_.]+)$")
end

-- "Meta-functions"
local meta = {
	-- Function call "operation"
	__call = function(self, repo, opts)
		opts = opts or vim.empty_dict()

		-- we declare some aliases for `do` and `for`
		opts['do'] = opts.run
		opts.run = nil

		opts['for'] = opts.ft
		opts.ft = nil

		vim.call('plug#', repo, opts)

		-- Add basic support to colocate plugin config
		if type(opts.config) == 'function' then
			local plugin = opts.as or plug_name(repo)

			if opts['for'] == nil and opts.on == nil then
				configs.start[plugin] = opts.config
			else
				configs.lazy[plugin] = opts.config
				vim.api.nvim_create_autocmd('User', {
					pattern = plugin,
					once = true,
					callback = function()
						apply_config(plugin)
					end,
				})
			end
		end
	end
}

-- Meta-tables are awesome
return setmetatable(Plug, meta)
