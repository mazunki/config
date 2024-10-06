return {
	url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	init = function()
		require("lsp_lines").setup()
	end,
	config = function()
		vim.keymap.set("n", "<leader>l", require("lsp_lines").toggle, { desc = "toggle lsp_lines" })

		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = {
				highlight_whole_line = false,
				wrap_long_lines = true,
			},
		})
	end,
}
