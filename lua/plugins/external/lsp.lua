local func = require('plenary.functional')
local lsconfig = require('lspconfig')

local lua = {
    runtime = { version = 'LuaJIT' },
    diagnostics = { globals = { 'vim' } },
    telemetry = { enable = false },
}

local servers = {
    tsserver = {},
    pyright = {},
    svelte = {},
    rust_analyzer = {},
    sumneko_lua = { settings = { Lua = lua } },
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return function(register, attach)
    local onatt = function(client, buffer) register(attach, client, buffer) end
    local opts = { on_attach = onatt, capabilities = capabilities }
    func.kv_map(function(kv)
        local server, options = unpack(kv)
        lsconfig[server].setup(vim.tbl_extend('force', opts, options))
    end, servers)
end
