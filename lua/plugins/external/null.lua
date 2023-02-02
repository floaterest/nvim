local null = require('null-ls')
-- local di = null.builtins.diagnostics
local ca = null.builtins.code_actions
local fo = null.builtins.formatting

local eslint = {
    filetypes =  {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
        'svelte',
    }
}

local sources = {
    ca.eslint_d.with(eslint),
    fo.eslint_d.with(eslint),
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
