
new_group = require("utils").create_augroup

new_group{
	name = "latex",
	ext = {"tex", "latex"},
	events = require("groups/latex").cmds
}

new_group{
	name = "js",
	ext = {"js", "json"},
	events = require("groups/js").events
}

new_group{
	name = "pdf",
	ext = {"pdf"},
	events = require("groups/pdf").events
}

new_group{
	name = "text",
--	ext = {"txt"},
	events = require("groups/txt").events
}
new_group{
	name = "markdown",
	ext = {"md"},
	events = require("groups/markdown").events
}

