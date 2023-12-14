local context_manager = require('plenary.context_manager')
local with = context_manager.with
local open = context_manager.open
local scan = require('plenary.scandir').scan_dir
local arts = scan(vim.fn.stdpath('config') .. '/alpha/')

local header = {
    type = 'text',
    val = {},
    opts = {
        position = 'center',
        hl = 'Type'
    }
}

-- RNG (?)
local i = os.time() % #arts + 1
with(open(arts[i], 'r'), function(reader)
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
                dashboard.button('f', '  Open file', '<cmd>Telescope find_files<cr>'),
                dashboard.button('r', '  Open Recent', '<cmd>Telescope oldfiles<cr>'),
                dashboard.button('g', '  Find text', '<cmd>Telescope live_grep<cr>'),
                dashboard.button('q', '  Quit', '<cmd>qa<cr>'),
            },
            opts = { spacing = 1 },
        }
    },
})