function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- set leader key to spc
vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' 

-- move display line
-- map('v', 'j', 'gj')
-- map('v', 'k', 'gk')
-- map('n', 'j', 'gj')
-- map('n', 'k', 'gk')

-- delete word
map('i', '<c-bs>', '<c-w>')
-- yank until end of line
map('n', 'Y', 'v$hy')
-- no ex-cammand
map('n', 'Q', '')

--[[
    files that also contains mappings:
    - plugins
      - luasnip.lua
      - whichkey.lua
]]--
