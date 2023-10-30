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

local function lines(reader)
    repeat
        local line = reader:read('*l')
        table.insert(header.val, line)
    until line == nil
end
with(open(path, 'r'), lines)

local dashboard = require('alpha.themes.dashboard')
local buttons = {
    type = 'group',
    val = {
        dashboard.button('f', '  Find file',       '<cmd>Telescope find_files<cr>'),
        dashboard.button('r', '  Recent files',    '<cmd>Telescope oldfiles<cr>'),
        dashboard.button('g', '  Find text',       '<cmd>Telescope live_grep<cr>'),
        dashboard.button('q', '  Quit',            '<cmd>qa<cr>'),
    },
    opts = { spacing = 1 },
}
require('alpha').setup({
    layout = {
        header,
        { type = 'padding', val = 1 },
        buttons
    },
    opts = { margin = 5 },
})