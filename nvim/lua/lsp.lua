local packer = require("packer")
local use = packer.use

local function on_attach_callback(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --buf_set_keymap('n', '<space>x', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    --buf_set_keymap('n', '<space>xx', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    --buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- core dependency for lsp support
use { 'neovim/nvim-lspconfig' }

use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
}

use { 'hrsh7th/nvim-cmp' }
use { 'hrsh7th/cmp-nvim-lsp' }

local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp = require('cmp')
cmp.setup({})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { focusable = false }
)
vim.api.nvim_create_augroup("lsp_completion_group", { clear = true })
vim.api.nvim_create_autocmd({"CursorHoldI"}, {
	group = "lsp_completion_group",
	callback = vim.lsp.buf.signature_help,
})


-- Diagnostic symbols in the sign column
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- linter for many languages
use { 'w0rp/ale',
	ft = {
		"python",
		"sh",
		"bash",
	}
}

-- git tracker (commented out because w0rp/ale giving issues for some reason)
use {
	'tanvirtin/vgit.nvim',
	requires = { "nvim-lua/plenary.nvim" }
}


use { 'elzr/vim-json', } -- json
use { 'latex-lsp/texlab', } -- latex lsp
use { 'microsoft/pyright', } -- python lsp
use { 'simrat39/rust-tools.nvim', } -- rust lsp
use { 'sumneko/lua-language-server' } --lua lsp


local lsp_cmd = {
	["clangd"] = { "clangd", "--background-index", "--suggest-missing-includes" },
	["sumneko_lua"] = {
		vim.fn.stdpath("data") .. "/site/pack/packer/start/lua-language-server/bin/lua-language-server"
	},
}
local lsp_ft = {
	["clangd"] = { "c", "cpp", "objc", "objcpp" },
}
local lsp_settings = {
	["sumneko_lua"] = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
}

local servers = { 'clangd', 'pyright', 'bashls', "sumneko_lua" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach_callback,
        capabilities = capabilities,
		cmd = lsp_cmd[lsp],
		ft = lsp_ft[lsp],
		settings = lsp_settings[lsp]
    })
end


use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    require("lsp_lines").setup({})
	vim.diagnostic.config({
		virtual_text = false,  -- removes duplication of diagnostic messages due to lsp_lines
		virtual_lines = true
	})
  end,
}

local diagnostics_virtual_text_value = false  -- wish i could query it directly and avoid this tempvar
vim.keymap.set("n", "<F12>", function()
	diagnostics_virtual_text_value = not diagnostics_virtual_text_value
	vim.diagnostic.config({
		virtual_text = diagnostics_virtual_text_value,
		virtual_lines = not diagnostics_virtual_text_value,
	})
end)

