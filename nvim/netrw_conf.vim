

" Directory browser
let g:netrw_keepdir = 0			" autosyncs the directory
let g:netrw_winsize = 25		" 20% width
let g:netrw_banner = 0			" hide help banner
let g:netrw_browsesplit = 3		" automatically use last buffer
let g:netrw_localcopydircmd = 'cp -r'	" allows copying directories too
let g:netrw_liststyle = 3		" defaults to tree mode


" hi! link netrwMarkFile Search
augroup netrw_settings
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END
function NetrwMapping()
	<leader>x :call NetrwCollapse()<CR>
endfunction

function! NetrwCollapse()
	redir => cnt
	silent .s/|//gn
	redir END
	let lvl = substitute(cnt, '\n', '', '')[0:0] - 1
	exec '?^\(| \)\{' . lvl . '\}\w'
	exec "normal \<CR>"
endfunction
