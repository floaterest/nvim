vim.o.gfn = 'Iosevka Custom NF,UD デジタル 教科書体 N-R:h14'

vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0.25


vim.g.neovide_scale_factor = 1.3
local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<C-=>', function()
    change_scale_factor(1.25)
end)
vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1/1.25)
end)
