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
		"nvim-treesitter/nvim-treesitter",
		config = "vim.cmd[[TsUpdate]]"
	}
	use {
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup {
				-- here goes config of twilight
			}
		end
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
			"tex",
			"python",
		},
		cmd = "ALEEnable",
		config = "vim.cmd[[ALEEnable]]"
	}

	use {
		"kana/vim-textobj-user"
	}
	use {
		"bps/vim-textobj-python"
	}

	use {
		"navarasu/onedark.nvim"
	}
	require("onedark").load()
	
	use { "unblevable/quick-scope" }
	use { "kshenoy/vim-signature" }

end)
