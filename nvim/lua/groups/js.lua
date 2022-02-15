
map = require("bindings/map")
local M = {}
M.cmds = {
	bufreadpost = { 
		"silent 1,$!js-beautify",
	}
}

-- map("n", "<Leader>==", ":w<CR>ggdG:r!js-beautify %<cr>")



return M

