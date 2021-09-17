

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
	Plug 'davidhalter/jedi-vim'
	Plug 'elzr/vim-json'
	Plug 'nvim-lua/completion-nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'latex-lsp/texlab'
call plug#end()


lua require'lspconfig'.texlab.setup{}
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

