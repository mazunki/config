local capabilities = require("lsp.capabilities")

require("mason").setup()
local servers = {
	clangd = {},
	-- gopls = {},
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic", -- or strict
					diagnosticSeverityOverrides = {
						reportUnusedImport = "none",
						reportUnusedVariable = "none",
						reportMissingImports = "none",
					},
				},
			},
		},
	},
	rust_analyzer = {},
	lua_ls = {},
	bashls = {
		settings = {
			shellcheckArguments = "-e 2034",
		},
	},
	zls = {},
	jdtls = {},
}
local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { "stylua" })
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

local handlers = {
	function(server_name)
		local server = servers[server_name] or {}
		server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
		require("lspconfig")[server_name].setup(server)
	end,
	["lua_ls"] = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			settings = {
				Lua = { diagnostics = { globals = { "vim" } } },
			},
		})
	end,
	["bashls"] = function()
		local lspconfig = require("lspconfig")
		lspconfig.bashls.setup({
			settings = {
				shellcheckArguments = "-e 2034",
			},
		})
	end,
	["ltex"] = function()
		local lspconfig = require("lspconfig")
		lspconfig.ltex.setup({
			language = "",
			enabled = true,
			dictionary = {},
		})
	end,
}
require("mason-lspconfig").setup({
	handlers = handlers,
})
