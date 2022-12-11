
-- Diagnostic symbols in the sign column
local signs = {
	Error = '',
	Warn = '',
	Hint = '',
	Info = '',
}
for level, icon in pairs(signs) do
  local hl =  "DiagnosticSign" .. level
  vim.fn.sign_define(hl ,{
	  text = icon,
	  texthl = hl,
	  numhl = hl
  })
end
