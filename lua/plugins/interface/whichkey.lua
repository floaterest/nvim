local which = require('which-key')
local keymaps = require('core.keymaps').which()

which.setup({
    key_labels = {
        ['<space>'] = 'spc'
    },
    icons = {
        breadcrumb = '›',
        separator = '→',
    },
    hidden = { 'b%d$' }
})

which.register(keymaps)
