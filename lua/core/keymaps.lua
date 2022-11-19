-- all non-default keymaps are here

local M = {}

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- keymaps that don't depend on plugins
function M.vanilla()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '
    -- delete word
    map('i', '<c-bs>', '<c-w>')
    -- delete all chars before cursor, but put them in register
    map('i', '<c-u>', '<esc>v^d')
    -- yank until end of line
    map('n', 'Y', 'v$hy')
    -- no ex-cammand
    map('n', 'Q', '')
end

-- which-key
M.which = {
    ['<leader>'] = {
        b = {
            name = '+buffer',

            ['1'] = { '<cmd>b1<cr>', 'which_key_ignore'},
            ['2'] = { '<cmd>b2<cr>', 'which_key_ignore'},
            ['3'] = { '<cmd>b3<cr>', 'which_key_ignore'},
            ['4'] = { '<cmd>b4<cr>', 'which_key_ignore'},
            ['5'] = { '<cmd>b5<cr>', 'which_key_ignore'},
            ['6'] = { '<cmd>b6<cr>', 'which_key_ignore'},
            ['7'] = { '<cmd>b7<cr>', 'which_key_ignore'},
            ['8'] = { '<cmd>b8<cr>', 'which_key_ignore'},
            ['9'] = { '<cmd>b9<cr>', 'which_key_ignore'},

            n = { '<cmd>bn<cr>', 'Go to next' },
            p = { '<cmd>bp<cr>' ,'Go to previous' },
            d = { '<cmd>bd<cr>', 'Delete' }
        },
        f = {
            name = '+file',
            b = { '<cmd>Telescope buffers<cr>', 'Find buffer' },
            f = { '<cmd>Telescope find_files<cr>', 'Find file' },
            s = { '<cmd>w<cr>', 'Save file' },
            S = { '<cmd>wa<cr>', 'Save all files' },
        },
        w = {
            name = '+window',
            h = { '<c-w>h', 'Go to left' },
            l = { '<c-w>l', 'Go to right' },
            v = { '<c-w>v', 'Split' },
            s = { '<c-w>s', 'Split window vertically' },
            x = { '<c-w>x', 'Swap current with next' },
            q = { '<c-w>q', 'Quit a window' },
            ['>'] = { '<c-w>>', 'Increase Width' },
            ['<'] = { '<c-w><', 'Decrease Width' },
            ['='] = { '<c-w>=', 'Make equal size' },
        },
    },
}

return M
