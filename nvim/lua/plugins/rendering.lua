#!/usr/bin/env lua
return {
	{
		"3rd/image.nvim",
		opts = {
			integrations = {
				markdown = {
					only_render_image_at_cursor = true,
				},
			},
		},
		dependencies = {
			"leafo/magick",
			"nvim-treesitter/nvim-treesitter",
			{
				"vhyrro/luarocks.nvim",
				opts = {
					rocks = {
						hererocks = true,
					},
				},
			},
		},
	},
	{
		"TobinPalmer/pastify.nvim",
		opts = {},
	},
}
