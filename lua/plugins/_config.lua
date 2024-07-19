return {
    leap = function()
        require('leap').add_default_mappings()
    end,
    presence = {
        neovim_image_text = 'Neovim',
        buttons = false,
    },
    typst = {
        port = 8080,
        get_root = function(_)
            return vim.fn.getcwd()
        end,
    },
    bufferline = {
        options = {
            separator_style = { '', '' },
            hover = {
                enabled = true,
                delay = 0,
                reveal = { 'close' },
            },
        },
    },
    gitsigns = { signcolumn = false, numhl = true },
    session = function()
        local config = require('session_manager.config')
        local session = require('session_manager')
        session.setup({
            autoload_mode = config.AutoloadMode.Disabled,
        })
    end,
    tree = {
        disable_netrw = true,
        hijack_cursor = true,
        renderer = {
            add_trailing = true,
            highlight_git = true,
            icons = {
                git_placement = 'signcolumn',
            },
        },
    },
}
