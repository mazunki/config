
call plug#begin(stdpath("data") . '/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'https://tpope.io/vim/fugitive.git'
	Plug 'https://tpope.io/vim/surround.git'
call plug#end()

" Directory browser
let g:netrw_keepdir = 0			" autosyncs the directory
let g:netrw_winsize = 30		" 20% width
let g:netrw_banner = 0			" hide help banner
let g:netrw_browsesplit = 3		" automatically use last buffer
let g:netrw_localcopydircmd = 'cp -r'	" allows copying directories too
let g:netrw_liststyle = 3		" defaults to tree mode
hi! link netrwMarkFile Search

hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=NONE guifg=white
hi CursorColumn cterm=NONE ctermbg=darkgray ctermfg=NONE guifg=white
set cursorline hi
" set cursorcolumn hi

:set scrolloff=9999

" bindings
let mapleader = " "
set timeoutlen=350
set ttimeoutlen=350
" change splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>` :below 10split<cr><C-w>j:term<cr>A
tnoremap <leader>` <C-\><C-n><C-w>k

" generic building
nnoremap <leader>b :make build<cr>

" because who can be arsed to type common commands
nnoremap <leader>e :Lex %:p:h<cr>
nnoremap <leader>w :w !doas tee %<cr>

augroup comment_line
	autocmd!
	autocmd Filetype c,cpp,java,scala	let b:comment_leader = '// '
	autocmd Filetype sh,ruby,pthon		let b:comment_leader = '# '
	autocmd FileType conf,fstab		let b:comment_leader = '# '
	autocmd FileType tex,latex		let b:comment_leader = '% '
	autocmd FileType mail			let b:comment_leader = '> '
	autocmd FileType vim			let b:comment_leader = '" '
augroup END
noremap <silent> <leader>/ :<C-B>silent s/^\([^<C-R>=escape(b:comment_leader,'\/')<CR>]\)/<C-R>=escape(b:comment_leader,'\/')<CR>\1/e<cr>:nohlsearch<cr>
noremap <silent> <leader>, :<C-B>silent s/^\(\w*\)<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>


