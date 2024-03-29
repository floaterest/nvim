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

local modes = {
    NORMAL = 'No', INSERT = 'In', SELECT = 'Se',
    VISUAL = 'Vi', ['V-LINE'] = 'VL', ['V-BLOCK'] = 'VB', VREPLACE = 'VR',
    COMMAND = 'Co', Terminal = 'Te', ['O-PENDING'] = 'OP', REPLACE = 'Re',
    -- insert-normal insert-visual, insert-select
}

local mode = { 'mode', fmt = function(s) return modes[s] or s end }
local filename = {
    'filename',
    -- relative path
    path = 1,
    symbols = { modified = ' [+]', readonly = ' [r]', unnamed = '[untitled]' }
}

local function location()
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    -- return string.format('%3d:%-2d', line, col)
    return line .. ':' .. col
  end

lualine.setup({
    options = { theme = theme },
    sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename, 'diagnostics' },
        lualine_x = { 'encoding' },
        lualine_y = { 'filetype' },
        lualine_z = { location }
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
