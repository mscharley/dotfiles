local symbols = {
	unix = ' ', -- e712
	dos = ' ', -- e70f
	mac = ' ', -- e711
}

local M = function()
	local format = vim.bo.fileformat
	local wrapping = require('wrapping').get_current_mode()
	return (symbols[format] or format) .. (wrapping == nil and '' or wrapping == 'hard' and '(h)' or '(s)')
end

return M
