-- some helper functions to hook into vim
local set = require("functions/vim/set")
local setopt = require("functions/vim/setopt")
local let = require("functions/vim/vars").let

-- side numbers
set("number")
set("relativenumber")

-- i like my indents to be tabs visually appearing as 4 width
set("expandtab", false) -- whether to turn tabs into spaces
set("shiftround", true) -- whether to turn spaces into tabs if tabstop length
set("tabstop", 4) -- aka how many cols a tab in file counts as
set("softtabstop", 4) -- aka how many cols a tab inserted counts as
set("shiftwidth", 4) -- aka how many cols to change when indenting

-- autocomplete options
set("completeopt", "menuone,preview,noinsert,noselect")

set("ignorecase")
set("smartcase")

set("shortmess", "flnrxstWIc") -- removes clutter tbh

set("list", false)
setopt("listchars", {
	eol='⏎',
	tab='▸—',
	nbsp='⎵',
	trail='·',
	space='·'
})
vim.cmd([[
hi Whitespace cterm=NONE ctermbg=NONE ctermfg=WHITE guibg=NONE guifg=#301000
]])

set("mapleader", " ", true)
set("python3_host_prog", "/usr/bin/python3.10", true)
-- set("$VIRTUAL_ENV", "neovim", true)

require("plugins")
require("bindings")
require("groups")
-- require("hisentence").load()

