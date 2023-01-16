local f = require("plenary.functional")

local M = {
	elements = {
        -- order matters
		breakpoints = { enabled = false, position = "left" },
		stacks = { enabled = false, position = "left" },
		watches = { enabled = false, position = "left" },
		repl = { enabled = false, position = "left" },
		scopes = { enabled = true, position = "bottom" },
		console = { enabled = true, position = "bottom" },
	},
	size = {
		left = 0.15,
		bottom = 0.3,
	},
}

function M.layouts()
    -- map position to elements and size
	local layouts = {}
	for position, size in pairs(M.size) do
		layouts[position] = { elements = {}, size = size }
	end
	for name, e in pairs(M.elements) do
		if e.enabled then
			table.insert(layouts[e.position].elements, name)
		end
	end

	return f.kv_map(function(kv)
		return {
			elements = kv[2].elements,
			size = kv[2].size,
			position = kv[1],
		}
	end, layouts)
end

return M
