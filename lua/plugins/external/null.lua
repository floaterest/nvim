local null = require('null-ls')
local di = null.builtins.diagnostics
local ca = null.builtins.code_actions
local fo = null.builtins.formatting

local sources = {
    di.eslint_d,
    ca.eslint_d,
    fo.eslint_d,
}

null.setup({
    sources = sources,
})