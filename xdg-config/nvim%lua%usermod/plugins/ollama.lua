require('usermod.vimplug')('nomnivore/ollama.nvim', {
	config = function()
		require('ollama').setup({
			model = "codestral",
			url = "http://127.0.0.1:11434",
		})
	end
})

