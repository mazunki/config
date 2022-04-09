return function(key, val, global)
	if global then
		if val == nil then
			vim.g[key] = true
		else
			vim.g[key] = val
		end
	else
		if val == nil then
			vim.o[key] = true
		else
			vim.o[key] = val
		end
	end
end
