local dap = require('dap')
local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

return function(register, keymaps)
    require('dap-python').setup('/usr/bin/python')
    register(keymaps, dap)
end
