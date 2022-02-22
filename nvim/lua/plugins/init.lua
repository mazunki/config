return require("packer").startup(function()
	use "wbthomason/packer.nvim"

	use {
		'tpope/vim-dispatch',
		opt=true,
		cmd = { "Dispatch", "Make", "Focus", "Start" }
	}
	use {
		'tpope/vim-surround',
	}

	use {
		"w0rp/ale",
		ft = { 
			"sh", 
			"zsh", 
			"bash", 
			"c", 
			"cpp", 
			"cmake", 
			"html", 
			"markdown", 
			"racket", 
			"vim", 
			"tex" 
		},
		cmd = "ALEEnable",
		config = "vim.cmd[[ALEEnable]]"
	}

	use {
		-- "navarasu/onedark.nvim"
	}
	require("onedark").load()
	


end)
