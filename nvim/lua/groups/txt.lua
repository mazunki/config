
map = require("bindings/map")
local M = {}
M.events = {
	BufReadPost = { 
		"silent norm gg",
		"silent norm >G",
	},
	BufEnter = { 
		"silent set nonumber",
		"silent set norelativenumber",
		"silent highlight CursorLine gui=bold",
		"silent set cursorline",
		"silent set textwidth=100",
		"silent norm gwG",
		"set nolist",
		"autocmd CursorMoved * call HighlightSentence()",
	}
}
function M.init_group()
	return nil
end


return M

