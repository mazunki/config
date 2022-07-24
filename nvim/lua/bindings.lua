
-- :help map-overview
-- n = normal
-- v = visual, select
-- s = select
-- x = visual
-- o = operator-pending
-- i = insert
-- c = command-line
-- t = terminal

-- building
vim.keymap.set("n", "<Leader>b", "make")

-- reload nvim config
local function reload_config()
	vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
	vim.cmd("doautocmd BufEnter")
end
vim.keymap.set("n", "<F5>", reload_config)

-- toggle whitespace characters
vim.keymap.set("n", "<F4>", ":set list!<cr>")

-- easy buffers
vim.keymap.set("n", "<tab>", require("bufferlist").create_buffer)

-- visual scrolling
vim.keymap.set("n", "<Up>", "1")
vim.keymap.set("n", "<Down>", "1")


-- selecting words for query in visual mode
vim.keymap.set("x", "/", '"vy/\\Vv<CR>')
vim.keymap.set("x", "?", '"vy/\\V\\<v\\><CR>')
vim.keymap.set("x", "*", '"vy/\\V\\<v<CR>')
vim.keymap.set("x", "#", '"vy/\\Vv\\><CR>')


local function delete_special()
	if string.match(vim.api.nvim_get_current_line(), "^%s*$") then
		return '"_dd'
	else
		return 'dd'
	end
end
vim.keymap.set( "n", "dd", delete_special, { noremap = true, expr = true } )

