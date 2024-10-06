package.path = package.path .. ";" .. vim.fn.stdpath("config") .. "/config/?.lua"

require("options")
require("keymaps")
require("autoload.lazy")
require("vim-compat")

-- vim: ts=2 sts=2 sw=2 et
