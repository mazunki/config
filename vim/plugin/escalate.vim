
function! RootWrite()
	execute 'write! !doas tee % >/dev/null'
	set nomodified
endfunction
command RootWrite call RootWrite()

augroup AuEscalatedBuffer
	autocmd!
	autocmd BufReadPost * if &buftype == '' &&
		\ filewritable(expand('%')) == 0 |
		\ let b:needs_escalation=1 |
		\ set noreadonly |
		\ else | let b:needs_escalation=0 |
		\ endif
	autocmd BufEnter * if exists('b:needs_escalation') && b:needs_escalation == 1 |
		\ set background=dark |
		\ else | set background=light |
		\ endif
	autocmd BufWriteCmd * if exists('b:needs_escalation') && b:needs_escalation == 1 |
		\ call RootWrite() |
		\ else | silent! write |
		\ endif
augroup END



