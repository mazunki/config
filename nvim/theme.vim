set scrolloff=9999
set termguicolors " oh yeah real tasty
colorscheme melange
hi Normal cterm=NONE ctermbg=BLACK ctermfg=NONE guibg=#111111 guifg=NONE
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=#123456 guifg=NONE
hi CursorColumn cterm=NONE ctermbg=darkgray ctermfg=NONE guibg=#111134 guifg=NONE
"hi Whitespace cterm=NONE ctermbg=NONE ctermfg=WHITE guibg=NONE guifg=#301000
hi Whitespace cterm=NONE ctermbg=NONE ctermfg=WHITE guibg=NONE guifg=#aaaaaa
silent set cursorline highlight
silent set cursorcolumn highlight

" this looks kinda uhh weird in cterm with melange. use a proper terminal!
set list
	set listchars=eol:⏎,tab:▸—,nbsp:⎵,trail:·,space:·
        set number
set relativenumber
