local colors = require('colo.colors')
local lualine = require('lualine')

local theme = {
    normal = {
        a = { fg = colors.black, bg = colors.teal, gui = 'bold' },
        b = { fg = colors.lightest, bg = colors.darker },
        c = { fg = colors.lighter, bg = colors.black },
	},
    insert = {
        a = { fg = colors.black, bg = colors.sky, gui = 'bold' },
    },
    visual = {
        a = { fg = colors.black, bg = colors.orange, gui = 'bold' },
	},
    replace = {
        a = { fg = colors.black, bg = colors.purple, gui = 'bold' },
    },
    command = {
        a = { fg = colors.black, bg = colors.pink, gui = 'bold' },
	},
    inactive = {
        a = { fg = colors.lightest, bg = colors.gray, gui = 'bold' },
        b = { fg = colors.lighter, bg = colors.darker },
        c = { fg = colors.light, bg = colors.darkest },
    },
}

local filename = {
    'filename',
    path = 1, -- relative path
    symbols = {
        modified = ' [+]',
        readonly = ' [r]',
        unnamed = '[untitled]',
    }
}

lualine.setup({
    options = { theme = theme },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { filename, 'diagnostics' },
        lualine_x = { 'encoding', {
            'fileformat',
            symbols = {
                unix = 'LF',
                dos = 'CRLF',
                mac = 'CR'
            }},
            'bo:filetype'
        },
        lualine_y = { 'filesize' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename', 'diagnostics' },
        lualine_x = { 'filesize' },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'nvim-tree', --[[ 'nvim-dap-ui' ]] }
})
