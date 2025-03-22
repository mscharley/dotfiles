local palette = require('usermod.theme.colors')

local b = { bg=palette.bg1, fg=palette.grey }
local c = { bg=palette.bg_dim, fg=palette.grey }
local z = { bg=palette.bg3, fg=palette.grey }

return {
	normal   = { z=z, c=c, b=b, a = { bg=palette.cyan, fg=palette.bg0, gui='bold' } },
	insert   = { z=z, c=c, b=b, a = { bg=palette.yellow, fg=palette.bg0, gui='bold' } },
	visual   = { z=z, c=c, b=b, a = { bg=palette.orange, fg=palette.bg0, gui='bold' } },
	replace  = { z=z, c=c, b=b, a = { bg=palette.red, fg=palette.bg0, gui='bold' } },
	command  = { z=z, c=c, b=b, a = { bg=palette.green, fg=palette.bg0, gui='bold', } },
	inactive = {
		a = { bg=palette.bg_dim, fg=palette.grey, gui='bold' },
		b = { bg=palette.bg_dim, fg=palette.grey, gui='bold' },
		c = { bg=palette.bg_dim, fg=palette.grey, gui='bold' },
	},
}
