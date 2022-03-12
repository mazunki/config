
map = require("bindings/map")
local M = {}
local filename = vim.fn.expand("%:p")
local pdfname = vim.fn.substitute(filename, "md$", "pdf", "")
M.events = {
	BufReadPost = {
		'set nolist',
	},
	BufWritePost = {
		'silent !pandoc --pdf-engine xelatex -V "V:mainfont:DejaVuSans.ttf" -V "V:monofont:DejaVuSansMono.ttf" ' .. filename .. ' -o ' .. pdfname,
	}
}

return M

