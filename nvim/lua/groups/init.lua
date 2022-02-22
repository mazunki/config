
new_group = require("utils").create_augroup

new_group{
	name = "latex",
	ext = {"tex", "latex"},
	cmds = require("groups/latex").cmds.bufwritepre
}

new_group{
	name = "js",
	ext = {"js", "json"},
	when = { "BufReadPost" },
	cmds = require("groups/js").cmds.bufreadpost
}

new_group{
	name = "pdf",
	ext = {"pdf"},
	when = { "BufReadPost" },
	cmds = require("groups/pdf").cmds.bufreadpost
}

new_group{
	name = "text",
	ext = {"txt"},
	when = { "BufReadPost" },
	cmds = require("groups/txt").cmds.bufreadpost
}

