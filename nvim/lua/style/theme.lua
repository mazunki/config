return {
	-- themes
	{
		"ellisonleao/gruvbox.nvim",
		"kepano/flexoki-neovim",
		"savq/melange-nvim",
		"rmehri01/onenord.nvim",
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-latte")
		end,
		opts = {
			color_overrides = {
				latte = {
					--base = "#DED1CA",
					--mantle = "#CEC1AA",
					--crust = "#FF0011",
				},
			},
		},
	},
}
