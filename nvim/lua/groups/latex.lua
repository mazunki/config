
map = require("bindings/map")
local M = {}
M.events = {
	BufReadPost = {
		"call CompileAndOpenLatex()",
	},
	BufWinLeave = {
		"silent! execute '!latexmk -c'",
	}
}

function M.load()
	vim.cmd([[
	function! CompileAndOpenLatex()
		Dispatch latexmk -xelatex='xelatex -synctex=1 -interaction=nonstopmode' -pdfxe %
		" Dispatch latexmk -xelatex -pdfxe %
		call OpenZathura()
	endfunction

	function! WC()
		let filename = expand("%:p")
		echo filename
		let wcmd = "sed -n '/\\\\begin{document}/,/\\\\end{document}/p' " . filename . " | detex | wc -w | tr -d '[:space:]'"
		let ccmd = "sed -n '/\\\\begin{document}/,/\\\\end{document}/p' " . filename . " | detex | wc -c | tr -d '[:space:]'"
		let words = system(wcmd)
		let chars = system(ccmd)
		echo words  . " words"
		echo chars . " chars"
	endfunction
	command WC call WC()

	function! OpenZathura()
		let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
		call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
	endfunction
	function! OpenZathuraHandler(timer)
		call OpenZathura()
	endfunction

	nmap <leader><Enter> :call OpenZathura()<cr>
	]])
end




return M

