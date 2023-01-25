local null = require('null-ls')
-- local di = null.builtins.diagnostics
local ca = null.builtins.code_actions
local fo = null.builtins.formatting

local sources = {
    ca.eslint_d,
    fo.eslint_d,
    fo.blue, -- I'll use black when it supports single quotes
    fo.stylua,
}

return function(register, attach)
    null.setup({
        sources = sources,
        on_attach = function(client, buffer)
            register(attach, client, buffer)
        end,
    })
end
