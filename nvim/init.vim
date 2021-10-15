
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
	Plug 'simrat39/rust-tools.nvim' " rust lsp

	Plug 'dhruvasagar/vim-table-mode' " auto-align tables

	Plug 'https://tpope.io/vim/fugitive.git' " git support
	Plug 'https://tpope.io/vim/dispatch.git' " git support
	Plug 'savq/melange'		" theme
	Plug 'kshenoy/vim-signature'	" highlight marks in margin
	Plug 'unblevable/quick-scope'	" highlight usage of f motion
call plug#end()

runtime netrw_conf.vim
runtime commenting.vim
runtime theme.vim
runtime latex.vim

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
noremap <C-J> ddp
noremap <C-K> ddkkp

nnoremap <leader>` :below 10split<cr><C-w>j:term<cr>A
tnoremap <leader>` <C-\><C-n><C-w>k

" generic building
nnoremap <leader>b :!make build<cr>

" because who can be arsed to type common commands
nnoremap <leader>e :Lex %:p:h<cr>
nnoremap <leader>w :w !doas tee %<cr>


"lua require'lspconfig'.texlab.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyright.setup{ on_attach=require'completion'.on_attach }
lua require'rust-tools'.setup{}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

cmap w!! w !doas tee % > /dev/null<cr>

set fixendofline
set eol

