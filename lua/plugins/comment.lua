require('Comment').setup({
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    sticky = false,
    ignore = '^$', -- ignore empty lines
})
