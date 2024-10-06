return function()
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = 0, desc = "LSP: " .. desc })
	end

	map("]g", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true })
	end, "Goto next error")

	map("[g", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, wrap = true })
	end, "Goto prev error")

	map("]G", function()
		vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING, wrap = true })
	end, "Goto next warning")

	map("[G", function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARNING, wrap = true })
	end, "Goto prev warning")

	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

	map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

	map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	map("K", vim.lsp.buf.hover, "Hover Documentation")
end
