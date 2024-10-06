--
-- kickstart plugins
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "autoload.lsp" },
	{ import = "plugins.comment" },
	{ import = "plugins.completion" },
	{ import = "plugins.conform" },
	{ import = "plugins.mini" },
	{ import = "plugins.telescope" },
	{ import = "plugins.treesitter" },
	{ import = "plugins.which" },
	{ import = "plugins.rendering" },
	{ import = "style.theme" },
	{ import = "style.git-signs" },
	{ import = "style.todo-signs" },
	{ import = "style.lsplines" },
	{ import = "lsp.linting" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
	performance = {
		rtp = {
			paths = { "/usr/share/vim/vimfiles" },
		},
	},
	opts = { rocks = { hererocks = true } },
})

-- vim: sw=4 ts=4 noexpandtab
