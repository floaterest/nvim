local lsconfig = require('lspconfig')
local on_attach = require('core.keymaps').on_attach

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

vim.tbl_map(function(server)
    lsconfig[server].setup(vim.tbl_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
    }, options[server] or {}))
end, servers)
