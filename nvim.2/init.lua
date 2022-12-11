
-- loading packer first since we need to .init() it before
-- packer.use()'ing it elsewhere
Plugins = require("plugins")

Theme = require("theme")
Tabsandspaces = require("tabsandspaces")

Bindings = require("bindings")
The_lsp = require("lsp")
Completion = require("completion")

Objects = require("objects")

-- plugins.sync()


vim.api.nvim_set_option_value("updatetime", 1000, {})
vim.api.nvim_set_option_value("ignorecase", true, {})
vim.api.nvim_set_option_value("smartcase", true, {})

vim.api.nvim_set_option_value("grepprg", 'grep -R -n $*', {})

vim.cmd("packloadall")
vim.cmd("helptags ALL")

