

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'latexmk'

augroup latex
	autocmd!
	autocmd BufWritePost *.tex silent! execute "!latexmk -bibtex -pdf %"
	autocmd BufWinLeave *.tex silent! execute "!latexmk -c"
augroup END

function! WC()
    let filename = expand("%:p")
    echo filename
    let cmd = "sed -n '/\\\\begin{document}/,/\\\\end{document}/p' " . filename . " | detex | wc -w | tr -d '[:space:]'"
    let result = system(cmd)
    echo result . " words"
endfunction
command WC call WC()
