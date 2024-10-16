return {
	'tpope/vim-commentary',
	event = "BufReadPre",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"gleam",
			},
			command = "setlocal commentstring =//\\ %s",
		})
	end
}
