-- all non-default keymaps are here

local M = {}

local function noremap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


function M.map(t)
    vim.tbl_map(function(v) noremap(unpack(v)) end, t)
end


-- keymaps that don't depend on plugins
function M.vanilla()
    M.map({
        -- delete word
        { 'i', '<c-bs>', '<c-w>' },
        -- delete all chars before cursor, but put them in register
        { 'i', '<c-u>', '<esc>v^d' },
        -- yank until end of line
        { 'n', 'Y', 'v$hy' },
        -- no ex-cammand
        { 'n', 'Q', '' },
    })
end

-- which-key
function M.which()
    return {
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
end

-- nvim-cmp
function M.cmp(cmp, luasnip)
    return {
        -- tab to luasnip expand or cmp complete
        ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
         ['<s-tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
    }
end

return M
