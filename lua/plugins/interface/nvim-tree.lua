local tree = require('nvim-tree')
local api = require('nvim-tree.api')

local icons = {
    git_placement = 'signcolumn',
    glyphs = {
        git = {
            unstaged = 'M', staged = 'S',
            renamed = 'R', deleted = 'D',
            unmerged = 'U', untracked = 'U',
        },
    },
}

local renderer = { add_trailing = true, highlight_git = true, icons = icons }

return function(register, keymaps)
    tree.setup({
        disable_netrw = true, hijack_cursor = true,
        diagnostics = { enable = true, show_on_dirs = true },
        renderer = renderer,
    })
    register(keymaps, api)
end
