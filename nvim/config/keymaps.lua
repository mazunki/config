vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<Tab>", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader><Tab>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader><cr>", vim.lsp.buf.code_action, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { desc = "Go to type definition of object" })

vim.keymap.set({ "n", "x" }, "gP", "<cmd>Pastify<cr>")
vim.keymap.set({ "n", "x" }, "gp", "<cmd>PastifyAfter<cr>")

local function insert_timestamp()
	local options = {
		os.date("%Y-%m-%d"),
		os.date("%Y-%m-%d %H:%M"),
		os.date("%Y-%m-%dT%H:%M%z"),
		os.date("%H:%M"),
	}

	vim.fn.complete(vim.fn.col("."), options)
end

-- local function insert_snippet()
-- 	local options = {
-- 		table.concat({
-- 			'if __name__ == "__main__":',
-- 			"main()",
-- 		}, "\n"),
-- 	}
-- 	vim.fn.complete(vim.fn.col("."), options)
-- end

vim.keymap.set("i", "<C-x>d", insert_timestamp, { desc = "current date" })
-- vim.keymap.set("i", "<C-x>o", insert_snippet, { desc = "snippets" })

-- vim.keymap.set("i", "\\d", insert_timestamp, { desc = "current date" })

-- vim.keymap.set("n", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

local function get_first_non_empty(obj)
	if type(obj) == "function" then
		return obj()
	elseif type(obj) == "table" then
		for _, v in ipairs(obj) do
			if type(v) == "function" then
				v = v()
			end
			if v then
				return v
			end
		end
	else
		return obj
	end
end

local function set_operator_map(lhs, start, finish, opts)
	local start_map = get_first_non_empty(start)
	local end_map = get_first_non_empty(finish)
	local selector = start_map .. "o" .. end_map

	local linewise = opts.linewise or "around"
	local prefix
	if opts.prefix then
		prefix = opts.prefix
	elseif linewise == "around" then
		prefix = "a"
	elseif linewise == "inner" then
		prefix = "i"
	end
	local description = linewise .. " " .. (opts.target or "custom object")
	local kopts = { desc = description:sub(1, 1):upper() .. description:sub(2):lower() }
	local cmd_visual = ":normal! v"
	if opts.visual_line then
		cmd_visual = ":normal! V"
	end

	vim.keymap.set("x", prefix .. lhs, selector, kopts)
	vim.keymap.set("o", prefix .. lhs, cmd_visual .. selector .. "<cr>", kopts)
end

set_operator_map("G", "gg", "G", { target = "File" })
set_operator_map("m", "[m", "]M", { target = "Method" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
