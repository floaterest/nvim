local f = require("plenary.functional")
local dap = require("dap")
local dapui = require('dapui')
local windows = require("dapui.windows")
local config = require("dapui.config")
local render = require("dapui.render")
local ui_state = require("dapui.state")()

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
function M.update(setup)
	render.loop.clear()
	config.setup(setup)
	ui_state:attach(dap)
	for _, module in pairs(config.elements) do
		local elem = require("dapui.elements." .. module)
		elem.setup(ui_state)
		render.loop.register_element(elem)
		for _, event in pairs(elem.dap_after_listeners or {}) do
			dap.listeners.after[event]["DapUI " .. elem.name] = function()
				render.loop.run(elem.name)
			end
		end
	end

	windows.setup()
end

function M.toggle(element)
    M.elements[element].enabled = not M.elements[element].enabled
    local l = M.layouts()

    vim.cmd[[redir! > /tmp/l.txt ]]
    print(vim.inspect(l))
    print(vim.inspect(M.elements))
    vim.cmd[[redir END]]

    M.update({ layouts = l })
    dapui.toggle()
end

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

