return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"j-hui/fidget.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		require("lsp.keymaps")
		require("lsp.handlers")
		require("lsp.capabilities")
		require("lsp.servers")
	end,
}
-- vim: sw=4 ts=4 expandtab
