local attach = require('plugins.keymaps.attach')
local M = { which = nil }

local function incfont(amount)
    local font = vim.api.nvim_eval('&gfn')
    local a, b = font:find(':h%d+')
    local size = font:sub(a + 2, b)
    vim.o.gfn = font:sub(0, a + 1) .. size + amount .. font:sub(b + 1)
end

function M.setup(which)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    M.which = which
    which.register({
        Y = { 'v$hy', 'Yank until EOL' },
        ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
        [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
        ['<c-=>'] = { function() incfont(1) end, 'Increase font size' },
        ['<c-->'] = { function() incfont(-1) end, 'Decrease font size' },
    })

    which.register({
        L = { '<cmd>bn<cr>', 'Go to next' },
        H = { '<cmd>bp<cr>' ,'Go to previous' },
        b = {
            name = '+buffer',

            ['1'] = { '<cmd>b1<cr>', 'which_key_ignore' },
            ['2'] = { '<cmd>b2<cr>', 'which_key_ignore' },
            ['3'] = { '<cmd>b3<cr>', 'which_key_ignore' },
            ['4'] = { '<cmd>b4<cr>', 'which_key_ignore' },

            n = { '<cmd>bn<cr>', 'Go to next' },
            p = { '<cmd>bp<cr>' ,'Go to previous' },
            d = { '<cmd>bd<cr>', 'Delete' }
        },
        f = {
            name = '+file',
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
    }, { prefix = '<leader>' })
    -- local mappings = {
    --     h = { ';', 'Repeat last f, t, F or T [count] times' },
    --     j = { 'h', 'Left' },
    --     k = { 'j', 'Down' },
    --     l = { 'k', 'Up' },
    --     [';'] = { 'l', 'Right' },
    -- }
    -- which.register(mappings)
    -- which.register(mappings, { mode = 'x' })

    return M
end

function M.register(keymaps, ...)
    keymaps = type(keymaps) == 'function' and keymaps(...) or keymaps

    local keymaps, opts = unpack((type(keymaps) == 'table' and keymaps[1]) and {
        keymaps[1], keymaps[2]
    } or {
        keymaps, nil
    })

    local t = type(keymaps)
    if t == 'function'then
        M.which.register(keymaps(...), opts)
    elseif t == 'table' then
        M.which.register(keymaps, opts)
    else
        error(t .. ' is not a valid type for maps to register')
    end
end

M.attach = attach

function M.cmp(cmp, luasnip)
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    local function tab(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm()
        elseif cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end

    local function stab(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    return {
        -- tab to luasnip expand or cmp complete
        ['<tab>'] = cmp.mapping(tab, { 'i', 's' }),
        ['<s-tab>'] = cmp.mapping(stab, { 'i', 's' }),
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
    }
end

function M.dap(dap) return { {
    name = '+debug',
    d = { dap.continue, 'Debug/Continue' },
    b = { dap.toggle_breakpoint, 'Toggle breakpoint' },
}, { prefix = '<leader>d' } } end

function M.dapui(dapui, ui)
    --[[
    s scopes
    b breakpoints
    t stacks (threads)
    w watches
    r repl
    c console

    spc d p b j (put breakpoints down (left bottom))
    spc d p r l (put repl left (bottom left))
    spc d t b (toggle breakpoints window)
    spc d t s (toggle scopes window)
    spc d g b (set focus on breakpoints window) (idk how)
]]
    local toggle = {
        name = '+toggle',
        s = { function() ui.toggle('scopes') end, 'Scopes' },
        b = { function() ui.toggle('breakpoints') end, 'Breakpoints' },
        t = { function() ui.toggle('stacks') end, 'Stacks/Threads' },
        w = { function() ui.toggle('watches') end, 'Watch' },
        r = { function() ui.toggle('repl') end, 'REPL' },
        c = { function() ui.toggle('console') end, 'Console' },
    }
    return {
        {
            u = { dapui.toggle, 'Toggle UI' },
            t = toggle
        }, { prefix = '<leader>d' }
    }
end

function M.nvimtree(api) return {
    {
        t = { api.tree.toggle, 'Toggle tree' },
    },
    { prefix = '<leader>f' }
} end

function M.telescope(builtin) return {
    {
        f = { builtin.find_files, 'Find file' },
        b = { builtin.buffers, 'Find buffer'},
    },
    { prefix = '<leader>f' }
} end

return {
    setup = M.setup
}
