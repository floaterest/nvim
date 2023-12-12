local function format()
    vim.lsp.buf.format({
        async = true,
        -- only use null-ls to format
        filter = function(client) return client.name == 'null-ls' end
    })
end

-- https://neovim.io/doc/user/lsp.html#lsp-method
local methods = {
    ['textDocument/codeAction'] = {
        a = {
            name = '+action',
            a = { vim.lsp.buf.code_action, 'List code actions' },
        },
    },
    ['textDocument/rename'] = {
        r = {
            name = '+rename',
            r = { vim.lsp.buf.rename, 'Rename symbol' },
        },
    },
    ['textDocument/formatting'] = {
        ['='] = {
            name = '+format',
            ['='] = { format, 'Format file' },
        },
    },
    ['textDocument/definition'] = {
        gd = { vim.lsp.buf.definition, 'Definition' },
    },
    ['textDocument/implementation'] = {
        gi = { vim.lsp.buf.implementation, 'Implementation' },
    },
    ['textDocument/references'] = {
        gr = { vim.lsp.buf.references, 'References' },
    }
}

local function attach(client, buffer)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local leader = { g = { name = '+goto' } }
    for method, keymap in pairs(methods) do
        if client.supports_method(method) then
            leader = vim.tbl_extend('force', leader, keymap)
        end
    end

    return {{
        ['<leader>'] = leader,
        K = { vim.lsp.buf.hover, 'Hover' },
    }, { buffer = buffer }}
end

local M = { which = nil }


function M.setup(which)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '


    local function wincmd(key)
        return function() vim.cmd.wincmd(key) end
    end

    M.which = which
    which.register({
        L = { vim.cmd.bn, 'Go to next' },
        H = { vim.cmd.bp ,'Go to previous' },
        Y = { 'v$hy', 'Yank until EOL' },
        ['<c-s>'] = { vim.cmd.w, 'Save buffer' },
        ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
        [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
    })

    which.register({
        b = {
            name = '+buffer',
            n = { vim.cmd.bn, 'Go to next' },
            p = { vim.cmd.bp ,'Go to previous' },
            d = { vim.cmd.bd, 'Delete' }
        },
        f = {
            name = '+file',
            s = { vim.cmd.w , 'Save file' },
            S = { vim.cmd.wa, 'Save all files' },
        },
        w = {
            name = '+window',
            h = { wincmd('h'), 'Go to left' },
            l = { wincmd('l'), 'Go to right' },
            v = { wincmd('v'), 'Split vertically' },
            j = { wincmd('j'), 'Go to down' },
            k = { wincmd('k'), 'Go to up' },
            s = { wincmd('s'), 'Split horizontally' },
            x = { wincmd('x'), 'Swap' },
            q = { wincmd('q'), 'Quit' },
            ['>'] = { wincmd('>'), 'Increase Width' },
            ['<'] = { wincmd('<'), 'Decrease Width' },
            ['='] = { wincmd('='), 'Make equal size' },
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

    local keymaps, opts = unpack(
        (type(keymaps) == 'table' and keymaps[1]
    ) and { keymaps[1], keymaps[2] } or { keymaps, nil })

    local t = type(keymaps)
    if t == 'function' then
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
        local num, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_buf_get_lines(0, num - 1, num, true)[1]
        return col ~= 0 and line:sub(col, col):match('%s') == nil
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
        ["<CR>"] = cmp.mapping.confirm({
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
    }
end

function M.dap(dap) return {{
    name = '+debug',
    d = { dap.continue, 'Debug/Continue' },
    b = { dap.toggle_breakpoint, 'Toggle breakpoint' },
}, { prefix = '<leader>d' }} end

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
    return {{
        u = { dapui.toggle, 'Toggle UI' },
        t = toggle
    }, { prefix = '<leader>d' }}
end

function M.nvimtree(api) return {
    { t = { api.tree.toggle, 'Toggle tree' } },
    { prefix = '<leader>f' }
} end

function M.telescope(builtin) return {
    {
        f = { builtin.find_files, 'Find file' },
        b = { builtin.buffers, 'Find buffer'},
        g = { builtin.live_grep, 'Live grep'},
    },
    { prefix = '<leader>f' }
} end

return { setup = M.setup }
