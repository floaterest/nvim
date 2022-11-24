local keymaps = require('core.keymaps').comment()

require('Comment').setup({
    toggler = keymaps,
    sticky = false,
    ignore = '^$', -- ignore empty lines
})
