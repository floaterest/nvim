local cmp = require('cmp')
local luasnip = require('luasnip')
local keymaps = require('core.keymaps').cmp(cmp, luasnip)

local function notcomment()
    local context = require('cmp.config.context')
    -- if in command mode
    if vim.api.nvim_get_mode().mode == 'c' then
        return true
    end
    local treesitter = context.in_treesitter_capture("comment")
    local syntax = context.in_syntax_group("Comment")
    return not treesitter and not syntax
end

cmp.setup({
    enabled = notcomment,
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert(keymaps),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}