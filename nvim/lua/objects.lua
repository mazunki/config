
local packer = require("packer")
local use = packer.use

-- core dependency for user textobjects
use { 'kana/vim-textobj-user' }

-- python
use { 'bps/vim-textobj-python' }

-- around file
vim.keymap.set("x", "aG", "ggoG")
vim.keymap.set("o", "aG", ":normal VaG<cr>")

