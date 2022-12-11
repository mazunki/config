local packer = require("packer")
local use = packer.use

-- completion menu
use({ 'hrsh7th/nvim-cmp', })
local cmp = require('cmp')

-- completion sources which all need nvim-cmp
local completion_sources = {
	{ url="hrsh7th/cmp-nvim-lsp", name="nvim-lsp", desc="source for neovim's built-in language server client" },
	-- { url="hrsh7th/cmp-buffer", name="buffer", desc="for buffer words" },
	-- { url="hrsh7th/cmp-path", name="path" , desc="for filesystem paths" },
	-- { url="hrsh7th/cmp-cmdline", name="unknown", desc="for vim's cmdline" },
	-- { url="hrsh7th/cmp-nvim-lua", name="nvim_lua", desc="for neovim Lua API" },
	-- { url="uga-rosa/cmp-dictionary", name="dictionary", desc="https://github.com/uga-rosa/cmp-dictionary" },
}

for _, source in ipairs(completion_sources) do
	use({
		source.url,
		requires = { "hrsh7th/nvim-cmp" }
	})
end

local function comp_formatter(entry, vim_item)
	local type_map = {
		Text = "txt",
		Method = "met",
		Function = "func",
		Constructor = "()",
		Field = "field",
		Variable = "var",
		Class = "class",
		Interface = "interf",
		Module = "mod",
		Property = "prop",
		Unit = "u",
		Value = "val",
		Enum = "enum",
		Keyword = "keyw",
		Snippet = "snip",
		Color = "color",
		File = "i/o",
		Reference = "ref",
		Folder = "dir",
		EnumMember = "enumitem",
		Constant = "const",
		Struct = "struct",
		Event = "ev",
		Operator = "op",
		TypeParameter = "param",
	}

  vim_item.kind = type_map[vim_item.kind]
  -- vim_item.abrr = string.sub(vim_item.abbr, 1, 10)

  return vim_item
end

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length=3 },
	}),
	formatting = {
		max_width = 50,
		fields = { "kind", "abbr", "menu" },
		format = comp_formatter,
	}
})

vim.api.nvim_set_option_value("completeopt", "menuone,preview,noinsert,noselect", {})


