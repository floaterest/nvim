local wk = require('which-key')
local keymaps = require('core.keymaps').which

wk.setup({
    key_labels = {
        ['<space>'] = 'spc'
    },
    icons = {
        breadcrumb = "›",
        separator = "→",
    },
    hidden = { 'b%d$' }
})

wk.register(keymaps)
