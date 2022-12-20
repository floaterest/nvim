local dap = require('dap')

return function(keymaps)
    require('dap-python').setup('/usr/bin/python')
    keymaps(dap)
end
