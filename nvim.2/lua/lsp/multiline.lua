
local packer = require("packer")
local use = packer.use

use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", }

local function toggle_virtuals()
	vim.diagnostic.config({
		virtual_text = not vim.diagnostic.config().virtual_text,
		virtual_lines = not vim.diagnostic.config().virtual_lines,
	})
end

vim.keymap.set("n", "<F12>", toggle_virtuals)

vim.diagnostic.config({
	virtual_text = false,  -- removes duplication of diagnostic messages due to lsp_lines
	virtual_lines = true,
})

vim.keymap.set("n", "g?", function()
	vim.diagnostic.open_float()
end)

