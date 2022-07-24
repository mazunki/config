
-- loading packer first since we need to .init() it before
-- packer.use()'ing it elsewhere
local plugins = require("plugins")

local theme = require("theme")
local tabsandspaces = require("tabsandspaces")
local bindings = require("bindings")

local the_lsp = require("lsp")
local completion = require("completion")
local objects = require("objects")


-- plugins.sync()


vim.api.nvim_set_option_value("updatetime", 300, {})
vim.api.nvim_set_option_value("ignorecase", true, {})
vim.api.nvim_set_option_value("smartcase", true, {})

vim.api.nvim_set_option_value("grepprg", 'grep -R -n $*', {})

vim.cmd("packloadall")
vim.cmd("helptags ALL")

