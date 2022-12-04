local M = {}

local options = { silent = true, noremap = true }

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- silent noremap
-- (not snore map because it's silent)
local function snoremap(t, opts)
    if opts then
        opts = vim.tbl_extend('force', options, opts)
    end
    vim.tbl_map(function(v)
        local mode, key, action = unpack(v)
        vim.keymap.set(mode, key, action, opts)
    end, t)
end

--#region keymaps sorted alphabetically

-- nvim-cmp
function M.cmp(cmp, luasnip)
    local function tab(fallback)
        if cmp.visible() then
            if not cmp.get_selected_entry() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                cmp.confirm()
            end
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
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
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
    }
end

-- comment
function M.comment()
    return {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    }
end

-- LSP on_attach
function M.on_attach(_, n)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(n, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local function format()
        vim.lsp.buf.format({async = true})
    end
    snoremap({
        { 'n', 'gD', vim.lsp.buf.declaration },
        { 'n', 'gd', vim.lsp.buf.definition },
        { 'n', 'K', vim.lsp.buf.hover },
        { 'n', 'gi', vim.lsp.buf.implementation },
        { 'n', 'gr', vim.lsp.buf.references },
        { 'n', '<c-k>', vim.lsp.buf.signature_help },
        { 'n', '<leader>ca', vim.lsp.buf.code_action },
        { 'n', '<leader>D', vim.lsp.buf.type_definition },
        { 'n', '<leader>m=', format },
        { 'n', '<leader>mrr', vim.lsp.buf.rename },
    }, { buffer = n })
end

-- keymaps that don't depend on plugins
function M.vanilla()
    snoremap({
        -- delete word
        { 'i', '<c-bs>', '<c-w>' },
        -- delete all chars before cursor, but put them in register
        { 'i', '<c-u>', '<esc>v^d' },
        -- yank until end of line
        { 'n', 'Y', 'v$hy' },
        -- no ex-cammand
        { 'n', 'Q', '' },

        { 'n', '<leader>e', vim.diagnostic.open_float },
        { 'n', '[d', vim.diagnostic.goto_prev },
        { 'n', ']d', vim.diagnostic.goto_next },
        { 'n', '<leader>q', vim.diagnostic.setloclist },
    })
end

-- which-key
function M.which()
    -- prefix for LSP bindings
    local lsp = '[LSP] '
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
            c = {
                name = '+code',

                a = lsp .. 'Code action',
            },
            D = lsp .. 'Type definition',
            f = {
                name = '+file',
                b = { '<cmd>Telescope buffers<cr>', 'Find buffer' },
                f = { '<cmd>Telescope find_files<cr>', 'Find file' },
                s = { '<cmd>w<cr>', 'Save file' },
                S = { '<cmd>wa<cr>', 'Save all files' },
            },
            m = {
                name = '+major',
                
                ['='] = lsp .. 'Format file',
                r = {
                    -- i = lsp .. 'Organise imports',
                    -- f = lsp .. 'Rename file',
                    r = lsp .. 'Rename symbol',
                }
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
        g = {
            d = lsp .. 'Definition',
            D = lsp .. 'Declaration',
            i = lsp .. 'Implementation',
            r = lsp .. 'References',
        },
        K = lsp .. 'Hover', -- it is possible to see first-level mappings
        ['<c-k>'] = lsp .. 'Signature help'
    }
end

--#endregion keymaps 

return M
