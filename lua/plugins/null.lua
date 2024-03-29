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
    -- fo.jq,
    fo.rustfmt,
    fo.blue,
    fo.fourmolu,
    fo.clang_format,
}

return function(register, attach)
    null.setup({
        sources = sources,
        on_attach = function(client, buffer)
            register(attach, client, buffer)
        end,
    })
end
