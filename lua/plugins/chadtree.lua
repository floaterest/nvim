local chadsettings = {
    theme = {
        icon_glyph_set = 'ascii_hollow',
        text_colour_set = 'nerdtree_syntax_dark'
    }
}
vim.api.nvim_set_var('chadtree_settings', chadsettings)

vim.api.nvim_set_keymap('n','<c-n>',':CHADopen<cr>', {})
