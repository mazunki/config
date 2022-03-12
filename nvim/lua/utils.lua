
local M = {}

function M.create_augroup(args)
	local name = args.name
	local extensions = args.ext or {}
	local matches = args.re or {}
	local events = args.events or {}
	local lua_group = args.lua_group or nil
	
	if events == nil then
		return false
	end

	vim.cmd("augroup " .. name)
	vim.cmd("autocmd!")
	for _, match in ipairs(extensions) do
		for when, commands in next, events, nil do
			for _, cmd in ipairs(commands) do
				vim.cmd("autocmd " .. when .. " " .. "*." .. match .. " " .. cmd)
			end
		end
	end
	if lua_group ~= nil then
		init_group()
	end
	vim.cmd("augroup END")

	return true
end

return M

