local which = require('which-key')
local keymaps = require('plugins.keymaps')

which.setup({
    key_labels = { ['<space>'] = 'spc' },
    icons = { breadcrumb = '›', separator = '→' },
})

return keymaps.setup(which)
