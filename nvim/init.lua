-- some helper functions to hook into vim
local set = require("functions/vim/set")
local let = require("functions/vim/vars").let

-- side numbers
set("number")
set("relativenumber")

-- i like my indents to be tabs visually appearing as 4 width
set("expandtab", false)
set("tabstop", 4) -- aka how many cols a tab in file counts as
set("softtabstop", 4) -- aka how many cols a tab inserted counts as
set("shiftwidth", 4) -- aka how many cols to change when indenting

-- autocomplete options
set("completeopt", "menuone,preview,noinsert,noselect")

set("shortmess", "flnrxstWIc") -- removes clutter tbh

let.g("mapleader", " ")

require("plugins")
require("bindings")
require("groups")

