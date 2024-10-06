return {
	"echasnovski/mini.nvim",
	config = function()
		-- better around/inside
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
--  vim: set ts=8
