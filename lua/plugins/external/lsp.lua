local lsconfig = require('lspconfig')
local servers = {
    'tsserver',
    'pyright',
}

local options = {
    -- will add server-specific options later
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

return function(register, attach)
    vim.tbl_map(function(server)
        lsconfig[server].setup(vim.tbl_extend('force', {
            on_attach = function(client, buffer)
                register(attach, client, buffer)
            end,
            capabilities = capabilities,
        }, options[server] or {}))
    end, servers)
end
