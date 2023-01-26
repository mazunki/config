packer = require("packer")
local use = packer.use

-- some plugins
use { "unblevable/quick-scope" }  -- highlight f/t motions
use { "kshenoy/vim-signature" }  -- highlight marks in gutter


-- add support for many colours
vim.api.nvim_set_option_value("termguicolors", true, {})


-- disabling invisible characters by default, adding my favourite unicode
vim.api.nvim_set_option_value("list", false, {})
vim.opt.listchars:append({
	eol = '⏎',
	tab = '▸—',
	nbsp = '⎵',
	trail = '·',
	space = '·',
})


-- set up my theme
vim.api.nvim_set_hl(0, "Normal", {
	fg = nil,
	bg = nil,
})

vim.api.nvim_set_hl(0, "whitespace", {
	fg = '#333333',
	bg = nil,
})

vim.api.nvim_set_hl(0, "Pmenu", {  -- completion menu (also popups)
	fg = nil,
	bg = '#222222',
})

vim.api.nvim_set_hl(0, "VertSplit", {
	fg = '#884488',
	bg = nil,
})

vim.api.nvim_set_hl(0, "SignColumn", {
	fg = nil,
	bg = nil,
})

vim.api.nvim_set_option_value("signcolumn", "yes", {})


-- add line numbers to gutter
vim.api.nvim_set_option_value("number", true, {})
-- vim.api.nvim_set_option_value("relativenumber", true, {})


-- set up the layout for bufferline and stuff
vim.api.nvim_set_option_value("shortmess", "flnrxstWIc", {})  -- :help shortmess if you really wanna see

