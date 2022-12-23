require('Comment').setup(vim.tbl_extend('force', {
    sticky = false,
    ignore = '^$', -- ignore empty lines
}))
