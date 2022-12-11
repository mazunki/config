local packer = require("packer")
local use = packer.use

local function on_attach_callback(client, bufnr)
    -- Mappings.
    local opts = { noremap=true, silent=true, buffer=true }
	local cmp = require('cmp')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<F1>', vim.lsp.buf.hover, opts)

    vim.keymap.set('i', '<C-n>', cmp.select_next_item, opts)
    vim.keymap.set('i', '<C-p>', cmp.select_prev_item, opts)

    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', print(vim.inspect(vim.lsp.buf.list_workspace_folders)), opts)
    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<CR>', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<space>x', vim.lsp.diagnostic.show_line_diagnostics, opts)
    --vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
    --vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, opts)
    --vim.keymap.set('n', '<space>xx', vim.lsp.diagnostic.set_loclist, opts)
    --vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)

--	vim.api.nvim_create_augroup("lsp_completion_group", { clear = true })
--	vim.api.nvim_create_autocmd({"CursorHold"}, {
--		group = "lsp_completion_group",
--		callback = vim.lsp.buf.hover,
--})

end

-- core dependency for lsp support
use { 'neovim/nvim-lspconfig' }
local lspconfig = require("lspconfig")

-- regex goes brr
use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
}



-- i currently don't see the point in updating capabilities manually
--
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--capabilities.textDocument.completion.completionItem.snippetSupport = true


-- linter for many languages
use { 'w0rp/ale',
	ft = {
		"python",
		"sh",
		"bash",
	}
}

-- git tracker (commented out because w0rp/ale (i think? something about :Vgit duplicaiton) giving issues for some reason)
--use {
--	'tanvirtin/vgit.nvim',
--	requires = { "nvim-lua/plenary.nvim" }
--}


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
        -- capabilities = capabilities,  -- why can i comment this out?
		cmd = lsp_cmd[lsp],
		ft = lsp_ft[lsp],
		settings = lsp_settings[lsp]
    })
end

require("lsp/multiline")
require("lsp/gutter")


