
-- if wbthomason/packer.nvim is not in the expected path, we just bootstrap it from here
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if not vim.fn.isdirectory(install_path) then
	vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer = require("packer")
packer.init({
	auto_clean = false,
	-- non_interactive = true,
})

packer.use({
	'wbthomason/packer.nvim'
})

return packer

