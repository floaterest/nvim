if not vim.g.neovide then
    return
end

local partial = require('plenary.functional').partial
vim.o.gfn = 'Iosevka Custom NF,UD デジタル 教科書体 N-R:h20'

vim.g.neovide_remember_window_size = true
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0.25

vim.g.neovide_scale_factor = 1
local scale = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<C-=>', partial(scale, 1.25))
vim.keymap.set('n', '<C-->', partial(scale, 1 / 1.25))
