require('mini.indentscope').setup({
    draw = { delay = 0 },
    symbol = '│',
})

require('mini.comment').setup({
    options = {
        ignore_blank_line = true,
    }
})

require('mini.surround').setup({
    -- can't think of a way to map without conflict with leap
    mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = '',
        update_n_lines = '',

        suffix_last = 'l',
        suffix_next = 'n',
    }
})

require('mini.pairs').setup()
