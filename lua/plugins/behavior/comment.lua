local keymaps = require('core.keymaps').comment()

require('Comment').setup(vim.tbl_extend('force', {
    sticky = false,
    ignore = '^$', -- ignore empty lines
}, keymaps))
