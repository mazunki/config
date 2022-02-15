
map = require("bindings/map")
local M = {}
M.cmds = {
	bufreadpost = { 
		"silent 1,$!pdftotext - -",
		"silent %s///g",
		"silent set binary",
		"silent set noeol",
		"silent norm gg",
		"silent norm >G",
		"silent set nonumber",
		"silent set norelativenumber",
		"silent highlight CursorLine gui=bold",
		"silent set cursorline",
		"silent set textwidth=100",
		"silent norm gwG",
	}
}
function M.init_group()
	return nil
end


return M

