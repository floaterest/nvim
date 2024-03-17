local icons = {
	git_placement = "signcolumn",
}

local renderer = { add_trailing = true, highlight_git = true, icons = icons }

return {
	disable_netrw = true,
	hijack_cursor = true,
	renderer = renderer,
}
