M = {}
function M.create_buffer()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "file")
	vim.api.nvim_buf_set_name(buf, "Buffers")

	local ui = vim.api.nvim_list_uis()[1]
	width = 50
	height = 50

	buffers = {}
	for buffer = 1, vim.fn.bufnr('$') do
		if vim.fn.buflisted(buffer) == 1 then
			table.insert(buffers, buffer)
		end
	end

	local win = vim.api.nvim_open_win(buf, 1, {
		['relative'] = 'editor',
		['width'] = width,
		['height'] = #buffers,
		['col'] = (ui.width/2) - (width/2),
		['row'] = (ui.height) - #buffers - 5,
		['anchor'] = 'NW',
		['style'] = 'minimal',
		['border'] = 'rounded',
	})

	for buffer = 1, vim.fn.bufnr('$') do
		if vim.fn.buflisted(buffer) == 1 then
			vim.api.nvim_buf_set_lines(0, buffer-1, buffer, false, { vim.fn.bufname(buffer) })
		end
	end
	
	local ns = vim.api.nvim_create_namespace("buffer_selector")

	local function buffer_highlight_line()
		local cursor = vim.fn.getpos('.')
		vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
		vim.api.nvim_buf_add_highlight(buf, ns, "CursorLine", cursor[2]-1, 0, -1)
	end

	vim.api.nvim_create_augroup("buffer_selector", { clear = true })
	vim.api.nvim_create_autocmd({"CursorMoved"}, {
		group = "buffer_selector",
		buffer = buf,
		callback = buffer_highlight_line,
	})



	vim.keymap.set("n", "q", ":silent bd<cr>", { buffer = true, silent = true })
	vim.keymap.set("n", "", ":silent bd<cr>", { buffer = true, silent = true })
	vim.keymap.set("n", "<cr>", function()
		local chosen_file = vim.api.nvim_get_current_line()
		vim.cmd('bdelete')
		vim.cmd('buffer ' .. chosen_file)
	end, { buffer = true })

end

return M
