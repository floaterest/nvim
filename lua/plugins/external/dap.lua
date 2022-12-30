local dap = require('dap')

return function(register, keymaps)
    require('dap-python').setup('/usr/bin/python')
    register(keymaps(dap))
end
