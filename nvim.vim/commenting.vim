
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
