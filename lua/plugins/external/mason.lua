local lsconfig = require('lspconfig')
local on_attach = require('core.keymaps').on_attach

local servers = {
    'tsserver', 'pyright'
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = servers })

vim.tbl_map(function(server)
    lsconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end, servers)
