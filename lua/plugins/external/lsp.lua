local lsconfig = require('lspconfig')
local servers = {
    'tsserver',
    'pyright',
}

local options = {
    -- will add server-specific options later
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

return function(register, attach)
    local onatt = function(client, buffer) register(attach, client, buffer) end
    local opts = { on_attach = onatt, capabilities = capabilities }
    vim.tbl_map(function(server) lsconfig[server].setup(
        vim.tbl_extend('force', opts, options[server] or {})
    ) end, servers)
end
