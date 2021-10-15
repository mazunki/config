
" Plugins
call plug#begin(stdpath("data") . '/plugged')
	Plug 'nvim-lua/completion-nvim'
	Plug 'neovim/nvim-lspconfig'	" language server protocol

	Plug 'elzr/vim-json'		" json obv
	Plug 'latex-lsp/texlab'		" latex lsp
	Plug 'microsoft/pyright'	" python lsp
	Plug 'simrat39/rust-tools.nvim' " rust lsp

	Plug 'dhruvasagar/vim-table-mode' " auto-align tables

	Plug 'https://tpope.io/vim/fugitive.git' " git support
	Plug 'nvim-lua/plenary.nvim' " dependency for vgit
	Plug 'tanvirtin/vgit.nvim'
	
	Plug 'https://tpope.io/vim/dispatch.git' " async support
	Plug 'savq/melange'		" theme
	Plug 'kshenoy/vim-signature'	" highlight marks in margin
	Plug 'unblevable/quick-scope'	" highlight usage of f motion
call plug#end()

augroup reload_nvim_conf
	autocmd!
	autocmd! BufWritePost *.vim source %
augroup end

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
nnoremap <Enter> :noh<cr>

noremap <leader>gc :Git commit -m "" <C-R>=expand("%")<CR> <C-F>2Ba
noremap <leader>gp :Git push<cr>
noremap <leader>gP :Git pull<cr>
lua require("vgit").setup()

" allows moving lines around, both singular and visual blocks
nnoremap <C-J> :m .+1<CR>
nnoremap <C-K> :m .-2<CR>
vnoremap <C-J> :m '>.+1<CR>gv=gv
vnoremap <C-K> :m '<.-2<CR>gv=gv

nnoremap <leader>` :below 10split<cr><C-w>j:term<cr>A
tnoremap <leader>` <C-\><C-n><C-w>k

" generic building
nnoremap <leader>b :!make build<cr>

" because who can be arsed to type common commands
nnoremap <leader>e :Lex %:p:h<cr>
nnoremap <leader>w :w !doas tee %<cr>


" lsp servers
lua require("lspconfig").texlab.setup({ on_attach=require'completion'.on_attach })
lua require("rust-tools").setup({})
lua require("lspconfig").pyright.setup({ on_attach=require'completion'.on_attach })

inoremap <Tab> <C-N>
inoremap <S-Tab> <C-P>
set completeopt=menuone,noinsert,noselect
set complete-=i
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

cmap w!! w !doas tee % > /dev/null<cr>

set fixendofline
set eol

