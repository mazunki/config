-- ::. WORKFLOW DESCRIPTION .::
-- clear current highlighting
-- prepare variables
-- find start
-- find end
-- calc length
-- highlight text

M = {}
function M.load()
	vim.cmd([[
	function! HighlightSentence()
		" clear current highlighting
		call clearmatches()
		" messages clear

		" prepare variables. getpos = [bufnum, lnum, col, off]
		let s:cursorline = line('.')
		let s:cursorcol = col('.')

		call search("[A-Z]", "b")
		let s:prevline = line(".")
		let s:prevcol = col(".")
		call cursor(s:cursorline, s:cursorcol)

		call search("[.;]", "")
		let s:nextline = line(".")
		let s:nextcol = col(".")
		call cursor(s:cursorline, s:cursorcol)

		echom s:prevline s:prevcol s:nextline s:nextcol
		
		if s:prevline == s:nextline
			call matchaddpos('MySentence', [ [s:prevline, s:prevcol, s:nextcol-s:prevcol ] ])
		else
			if s:prevline == s:cursorline
				call matchaddpos('MySentence', [ [s:prevline, s:prevcol, s:cursorcol-s:prevcol ] ])
				call matchaddpos('MySentence', [ [s:cursorline, s:cursorcol, 999 ] ])
			else 
				call matchaddpos('MySentence', [ [s:prevline, s:prevcol, 999 ] ])
				let s:prevline += 1
				while s:prevline < s:cursorline
					call matchaddpos('MySentence', [ [ s:prevline ] ])
					let s:prevline += 1
				endwhile
				call matchaddpos('MySentence', [ [s:cursorline, 1, s:cursorcol ] ])
			end

			if s:cursorline == s:nextline 
				call matchaddpos('MySentence', [ [s:cursorline, 1, s:cursorcol ] ])
				call matchaddpos('MySentence', [ [s:cursorline, s:cursorcol, s:nextcol-s:cursorcol ] ])
			else 
				call matchaddpos('MySentence', [ [s:cursorline, s:cursorcol, 999 ] ])
				call matchaddpos('MySentence', [ [s:nextline, 1, s:nextcol ] ])
				let s:nextline -= 1
				while s:nextline > s:cursorline
					call matchaddpos('MySentence', [ [ s:nextline ] ])
					let s:nextline -= 1
				endwhile
			end
		end

		" highlight text

		"messages
	endfunction
		highlight MySentence ctermfg=green guifg=green
		autocmd CursorMoved * call HighlightSentence()

	]])
end

return M
-- foobar is. one sentence. another sentence. and one last sentence.
