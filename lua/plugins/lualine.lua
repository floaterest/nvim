local colors = require('colorscheme.colors')

local theme = {
    normal = {
        a = { fg = colors.black, bg = colors.leek, gui = 'bold' },
        b = { fg = colors.lightest, bg = colors.dark },
        c = { fg = colors.lighter, bg = colors.darkest },
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

require('lualine').setup({
    options = { theme = theme },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { filename },
        lualine_x = {
            'encoding', 
            { 
                'fileformat',
                symbols = {
                    unix = 'LF', 
                    dos = 'CRLF', 
                    mac = 'CR'
                } 
            },
            'bo:filetype'
        },
        lualine_y = { 'filesize' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        -- lualine_a = {'buffers'},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {'tabs'}
    },
    extensions = { 'nvim-tree' }
})