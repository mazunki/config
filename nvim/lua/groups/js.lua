
map = require("bindings/map")
local M = {}
M.cmds = {
	bufreadpost = { 
		":normal ggdG",
		"r!js-beautify %"
	}
}

-- map("n", "<Leader>==", ":w<CR>ggdG:r!js-beautify %<cr>")



return M

