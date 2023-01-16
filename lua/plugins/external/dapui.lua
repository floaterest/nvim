local dap = require("dap")
local dapui = require("dapui")
local layouts = require("plugins.external.ui").layouts()

local function setup(user_config)
	local windows = require("dapui.windows")
	local config = require("dapui.config")
	local render = require("dapui.render")
	local ui_state = require("dapui.state")()

	render.loop.clear()
	config.setup(user_config)
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

dapui.setup({
	layouts = layouts,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
