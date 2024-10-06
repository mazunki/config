return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufWritePost" },

	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "pylint" },
		}

		local lint_aug = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.keymap.set("n", "<F3>", function()
			lint.try_lint()
		end, { desc = "Trigger lingint for current file" })
	end,
}
