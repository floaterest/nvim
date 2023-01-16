local dap = require("dap")
local dapui = require("dapui")
local layouts = require("plugins.external.ui").layouts()

dapui.setup({ layouts = layouts })
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

