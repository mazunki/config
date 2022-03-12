
map = require("bindings/map")
local M = {}

function M.load() 
	map("i", "<Up>", "∧")
	map("i", "<Down>", "∨")
	map("i", "<Left>", "↔")
	map("i", "<Right>", "→")
	return true
end

return M

