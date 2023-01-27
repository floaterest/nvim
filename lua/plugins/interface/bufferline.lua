require('bufferline').setup({
    highlights = {
        buffer_selected = {
            bold = true
        }
    },
    options = {
        numbers = function(o) return string.format('%s', o.id) end,
        offsets = {{
            filetype = 'NvimTree',
            text = 'Explorer',
            highlight = 'Directory',
            text_align = 'left'
        }},
        buffer_close_icon = '✕',
        modified_icon = '●',
        close_icon = '✖',
        left_trunc_marker = '🡄',
        right_trunc_marker = '🡆',
        show_buffer_icons = false,
        show_close_icon = false,
        separator_style = 'thick',
        always_show_bufferline = true
    },
})
