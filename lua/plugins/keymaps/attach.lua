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

return function (client, buffer)
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
