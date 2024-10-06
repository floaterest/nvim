local which = require('which-key')
local partial = require('plenary.functional').partial

local function copy()
    vim.fn.setreg('+', vim.fn.join(vim.fn.getbufline('%', 1, '$'), '\n'), 'l')
    print('Copied buffer to clipboard')
end

local function bd()
    vim.cmd.bn()
    vim.cmd.bd('#')
end

local default = {
    -- { '<c-c>', copy, desc = 'Copy buffer' },
    { '<c-h>', vim.cmd.noh, desc = 'Stop the highlighting' },
    {
        '<c-p>',
        '<cmd>TypstPreview<cr>',
        cond = function()
            return vim.bo.filetype == 'typst'
        end,
        desc = 'Typst Preview',
    },
    { '<c-s>', vim.cmd.w, desc = 'Save buffer' },
    {
        '<c-n>',
        '<cmd>Noice dismiss<cr>',
        desc = 'Dismiss Noice',
        mode = { 'n', 'i', 'x' },
    },
    { 'H', vim.cmd.bp, desc = 'Previous buffer' },
    { 'L', vim.cmd.bn, desc = 'Next buffer' },
    { 'Y', 'y$', desc = 'Yank until EOL' },

    { '<leader>D', bd, desc = 'Delete buffer #' },
    { '<leader>P', '"+P', desc = 'System paste before', mode = { 'n', 'x' } },
    { '<leader>d', vim.cmd.bd, desc = 'Delete buffer' },
    { '<leader>p', '"+p', desc = 'System paste', mode = { 'n', 'x' } },
    { '<leader>q', vim.cmd.q, desc = 'Quit' },
    { '<leader>Q', vim.cmd.qa, desc = 'Quit all' },
    { '<leader>y', '"+y', desc = 'System yank', mode = 'x' },

    { '<leader>t', group = 'tab' },
    { '<leader>tt', '<cmd>tab sp<cr>', desc = 'New tab' },
    { '<leader>tc', vim.cmd.tabc, desc = 'Close tab' },
    { '<leader>to', vim.cmd.tabo, desc = 'Close all other tabs' },

    { '<leader>w', proxy = '<c-w>', group = 'window' },
}

local function format()
    vim.lsp.buf.format({ async = true })
end

-- https://neovim.io/doc/user/lsp.html#lsp-method
local server = {
    { '<leader>=', format, desc = 'Format file' },
    { '<leader>a', vim.lsp.buf.code_action, desc = 'List code actions' },
    { '<leader>r', vim.lsp.buf.rename, desc = 'Rename symbol' },

    { '<leader>g', group = 'goto' },
    { '<leader>gD', vim.lsp.buf.declaration, desc = 'Declaration' },
    { '<leader>gd', vim.lsp.buf.definition, desc = 'Definition' },
    { '<leader>gi', vim.lsp.buf.implementation, desc = 'Implementation' },
    { '<leader>gr', vim.lsp.buf.references, desc = 'References' },
    { 'K', vim.lsp.buf.hover, desc = 'Hover' },
    { '[d', vim.diagnostic.goto_prev, desc = 'Previous diagnostic' },
    { ']d', vim.diagnostic.goto_next, desc = 'Next diagnostic' },
}

--[[
    TODO dap dapui

    spc d d Debug/Continue
    spc d b (Toggle breakpoint)

    s scopes
    b breakpoints
    t stacks (threads)
    w watches
    r repl
    c console

    spc d t * (toggle * window)
    spc d p * j (put * down (left bottom))
    spc d p * l (put repl left (bottom left))
    spc d g b (set focus on breakpoints window) (idk how)
    spc d u (toggle ui)
]]

which.setup({
    replace = { key = { { '<Space>', 'SPC' } } },
    icons = { breadcrumb = '›', separator = '→' },
    preset = 'classic',
    spec = default,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        which.add(vim.tbl_map(function(t)
            return vim.tbl_extend('force', t, { buffer = ev.buf })
        end, server))
    end,
})

local status, api = pcall(require, 'Comment.api')
if status then
    which.add({
        { '<leader>c', api.toggle.linewise.current, desc = 'Comment line' },
        { '<leader>C', api.toggle.blockwise.current, desc = 'Comment block' },
    })
end

local status, builtin = pcall(require, 'telescope.builtin')
if status then
    which.add({
        { '<leader>f', builtin.find_files, desc = 'Find file' },
        { '<leader>F', group = 'telescope' },
        { '<leader>Ff', builtin.find_files, desc = 'Find file' },
        { '<leader>Fb', builtin.buffers, desc = 'Buffers' },
        { '<leader>Fd', builtin.diagnostics, desc = 'Diagnostics' },
        { '<leader>Ff', builtin.find_files, desc = 'Files' },
        { '<leader>Fg', builtin.live_grep, desc = 'Live grep' },
        { '<leader>Fh', builtin.highlights, desc = 'Highlights' },
        { '<leader>Fk', builtin.keymaps, desc = 'Keymaps' },
        { '<leader>Fm', builtin.marks, desc = 'Marks' },
        { '<leader>Fo', builtin.vim_options, desc = 'Vim options' },
        { '<leader>Fr', builtin.registers, desc = 'Registers' },
        { '<leader>Fn', '<cmd>Telescope noice<cr>', desc = 'Noice' },
    })
end

local status, api = pcall(require, 'nvim-tree.api')
if status then
    which.add({ '<leader>T', api.tree.toggle, desc = 'Toggle tree' })
end

local status, session = pcall(require, 'session_manager')
if status then
    which.add({
        { '<leader>s', session.load_session, desc = 'Select sessions' },
        { '<leader>S', group = 'Session' },
        { '<leader>Ss', session.load_session, desc = 'Select sessions' },
        { '<leader>Sd', session.delete_session, desc = 'Delete sessions' },
    })
end

local status, buffer = pcall(require, 'bufferline')
if status then
    which.add({
        { '<leader>b', buffer.pick, desc = 'Select buffer' },
        { '<leader>B', group = 'Buffer' },
        { '<leader>Bb', buffer.pick, desc = 'Select buffer' },
        {
            '<leader>Bd',
            buffer.close_with_pick,
            desc = 'Pick buffer to delete',
        },
        { '<leader>BD', buffer.close_others, desc = 'Close other buffers' },
    })
end

local status, noice = pcall(require, 'noice')
if status then
    which.add({
        { '<leader>n', partial(noice.cmd, 'all'), desc = 'Noice' },
    })
end

local status, agda = pcall(require, 'agda')
if status then
    local rewrite = require('agda.enums').Rewrite
    which.add({
        { '\\l', agda.load, desc = 'Load' },
        {
            '\\d',
            function()
                agda.infer(rewrite.SIMPLIFIED)
            end,
            desc = 'Deduce',
        },
        { '\\c', agda.case, desc = 'Split' },
        { '\\r', agda.refine, desc = 'Refine' },
        { '\\ ', agda.give, desc = 'Give' },
        {
            '\\,',
            function()
                agda.goal_type_context(rewrite.SIMPLIFIED)
            end,
            desc = 'Infer',
        },
    })
end
