local tree = require('nvim-tree')
local api = require('nvim-tree.api')

local icons = {
    git_placement = 'signcolumn',
    glyphs = {
        git = {
            unstaged = 'M',
            staged = 'S',
            renamed = 'R',
            unmerged = 'U',
            deleted = 'D',
            untracked = 'U',
        },
    },
}

return function(register, keymaps)
    tree.setup({
        disable_netrw = true,
        open_on_setup = true,
        open_on_tab = true,
        hijack_cursor = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        renderer = {
            add_trailing = true,
            highlight_git = true,
            icons = icons,
        },
    })
    register(keymaps, api)
end
