local on_attach = require('core.keymaps').on_attach

local servers = {
    'tsserver', 'pyright'
}


local lsp_flags = {
-- This is the default in Nvim 0.7+
debounce_text_changes = 150,
}



require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers
})

local lsconfig = require('lspconfig')
lsconfig['tsserver'].setup({
    on_attach = on_attach,
})
lsconfig['pyright'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
})
