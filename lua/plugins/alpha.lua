local context_manager = require('plenary.context_manager')
local with = context_manager.with
local open = context_manager.open
local path = vim.fn.stdpath('config') .. '/alpha/neovim.txt'

local header = {
    type = 'text',
    val = {},
    opts = {
        position = 'center',
        hl = 'Type'
    }
}

with(open(path, 'r'), function(reader)
    repeat
        local line = reader:read('*l')
        table.insert(header.val, line)
    until line == nil
end)

local dashboard = require('alpha.themes.dashboard')
require('alpha').setup({
    layout = {
        header,
        { type = 'padding', val = 1 },
        {
            type = 'group',
            val = {
                dashboard.button('f', '  Find file',       '<cmd>Telescope find_files<cr>'),
                dashboard.button('r', '  Recent files',    '<cmd>Telescope oldfiles<cr>'),
                dashboard.button('g', '  Find text',       '<cmd>Telescope live_grep<cr>'),
                dashboard.button('q', '  Quit',            '<cmd>qa<cr>'),
            },
            opts = { spacing = 1 },
        }
    },
    opts = { margin = 5 },
})