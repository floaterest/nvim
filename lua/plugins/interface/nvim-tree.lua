require("nvim-tree").setup({
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