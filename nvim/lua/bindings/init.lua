
map = require("bindings/map")

-- general bindings go here
-- language specific are loaded from lua/groups/init.lua
-- in order to support different filetypes per language

map("n", "<Leader>b", "make")
map("n", "<Up>", "1")
map("n", "<Down>", "1")
map("n", "<F5>", ":so ~/.config/nvim/init.lua<cr>:doautocmd BufEnter<cr>")
map("n", "<F4>", ":set list!<cr>")
map("x", "aG", "ggoG")
map("o", "aG", ":normal VaG<cr>")
map("n", "<tab>", ":ls<cr>:b ")

map("x", "/", '"vy/\\Vv<CR>')
map("x", "?", '"vy/\\V\\<v\\><CR>')
map("x", "*", '"vy/\\V\\<v<CR>')
map("x", "#", '"vy/\\Vv\\><CR>')
