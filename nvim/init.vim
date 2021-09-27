
" Plugins
call plug#begin(stdpath("data") . '/plugged')
	Plug 'davidhalter/jedi-vim'	" python
	Plug 'elzr/vim-json'		" json obv

	Plug 'nvim-lua/completion-nvim'
	Plug 'neovim/nvim-lspconfig'	" language server protocol
	Plug 'SirVer/ultisnips'		" Engine
	Plug 'honza/vim-snippets'	" Repo of snippts
	Plug 'latex-lsp/texlab'		" latex lsp
	Plug 'microsoft/pyright'	" python lsp

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'https://tpope.io/vim/fugitive.git'
	Plug 'savq/melange'
call plug#end()


" Directory browser
let g:netrw_keepdir = 0			" autosyncs the directory
let g:netrw_winsize = 25		" 20% width
let g:netrw_banner = 0			" hide help banner
let g:netrw_browsesplit = 3		" automatically use last buffer
let g:netrw_localcopydircmd = 'cp -r'	" allows copying directories too
let g:netrw_liststyle = 3		" defaults to tree mode

set scrolloff=9999

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

set termguicolors " oh yeah real tasty
colorscheme melange
hi Normal cterm=NONE ctermbg=BLACK ctermfg=NONE guibg=#111111 guifg=NONE
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=#123456 guifg=NONE
hi CursorColumn cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=#111134 guifg=NONE
silent set cursorline highlight
silent set cursorcolumn highlight

" this looks kinda uhh weird in cterm with melange. use a proper terminal!
set list
set listchars=eol:⏎,tab:▸—,nbsp:⎵,trail:·,space:·

set number
set relativenumber

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

" bindings
let mapleader = " "
set timeoutlen=350
set ttimeoutlen=350
" change splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
noremap <leader>y "*y
noremap <leader>p "*p
noremap <leader>c "+y
noremap <leader>v "+p

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

" trying to set up latex
lua require'lspconfig'.texlab.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyright.setup{ on_attach=require'completion'.on_attach }

" lua require'snippets'.use_suggested_mappings()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

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

cmap w!! w !doas tee % > /dev/null<cr>


set fixendofline
set eol

