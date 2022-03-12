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
		let s:fw_lineoffset = 0
		let s:bw_lineoffset = 0
		let s:cursorline = line('.')
		let s:cursorcol = col('.')

		let s:prevline = -1
		let s:prevcol = -1
		let s:nextline = -1
		let s:nextcol = -1

		while line(".") - s:bw_lineoffset > 0
			let s:query_line = getline(line(".") - s:bw_lineoffset)
			if s:bw_lineoffset == 0
				let s:query_line = strpart(s:query_line, 0, s:cursorcol)
			end

			let s:prevcol = match(s:query_line, "[.;^]*[A-Z]")
			if s:prevcol == -1
				let s:bw_lineoffset += 1
			else
				let s:prevline = line(".") - s:bw_lineoffset
				let s:prevcol += 1
				break
			end
		endwhile

		while line("$") - (line(".") + s:fw_lineoffset) > 0
			let s:query_line = getline(line(".") + s:fw_lineoffset)
			if s:fw_lineoffset == 0
				let s:query_line = strpart(s:query_line, s:cursorcol+1)
			end

			let s:nextcol = match(s:query_line, "[.;]")
			if s:nextcol == -1
				let s:fw_lineoffset += 1
			else
				let s:nextline = line(".") + s:fw_lineoffset
				if s:fw_lineoffset == 0
					let s:nextcol += s:cursorcol + 2
				end
				break
			end
		endwhile

		" echom s:prevline s:prevcol s:nextline s:nextcol
		
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
	highlight Normal gui=NONE guifg=#888888
	highlight MySentence gui=bold guifg=#cccccc guibg=NONE

	]])
end

return M
-- foobar is. one sentence. another sentence. and one last sentence.
