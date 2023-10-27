local cmp = require('cmp')
local luasnip = require('luasnip')

local function notcomment()
    local context = require('cmp.config.context')
    -- don't cmp in command mode
    if vim.api.nvim_get_mode().mode == 'c' then return false end
    local treesitter = context.in_treesitter_capture('comment')
    local syntax = context.in_syntax_group('Comment')
    return not treesitter and not syntax
end

return function(keymaps)
    cmp.setup({
        enabled = notcomment,
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert(keymaps(cmp, luasnip)),

        sources = cmp.config.sources({
            { name = "copilot" },
            { name = 'nvim_lua' }, -- one day I will develop my nvim config in nvim
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'nvim_lsp_signature_help' },
        })
    })
end
