local dap = require("dap")
local dapui = require("dapui")
local dui = require("plugins.external.dui")

return function(register, keymaps)
    dapui.setup({ layouts = dui.layouts() })
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    register(keymaps, dapui, dui)
end

