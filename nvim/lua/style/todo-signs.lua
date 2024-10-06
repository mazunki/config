return {
	"folke/todo-comments.nvim", -- better highlight of TODO README FIXME WARN eg
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}
