local dap = require("dap")
local dapui = require("dapui")
local ui = require("plugins.external.ui")

return function(register, keymaps)
    dapui.setup({ layouts = ui.layouts() })
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    register(keymaps, ui)
end

