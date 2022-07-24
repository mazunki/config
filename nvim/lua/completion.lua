
-- presses <C-n> after updatetime delay in insert mode (for automatic completion list)
vim.api.nvim_create_augroup("completion", { clear = true })
vim.api.nvim_create_autocmd({"CursorHoldI"}, {
	group = "completion",
	callback = function()
		local cursor = vim.fn.getpos(".")
		local text = vim.fn.getline(cursor[2])
		if string.match(text, "[%a.]", cursor[3]-1) then  -- %a = letters, %p punctuation
			vim.api.nvim_feedkeys("", '', false)
		end
	end,
})

vim.api.nvim_set_option_value("completeopt", "menuone,preview,noinsert,noselect", {})


