local tree =  require('nvim-tree')
local api = require('nvim-tree.api')

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
        view = {

        },
        renderer = {
            add_trailing = true,
            highlight_git = true,
            icons = {
                git_placement = 'signcolumn',
            }
        },
    })
    register(keymaps, api)
end
