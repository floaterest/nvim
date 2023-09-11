local func = require('plenary.functional')
local lsconfig = require('lspconfig')

-- local lua = {
--     runtime = { version = 'LuaJIT' },
--     diagnostics = { globals = { 'vim' } },
--     telemetry = { enable = false },
-- }

local rust = { ['rust-analyzer']= {
    diagnostics = {
        disabled = { 'inactive-code' },
    },
} }

local haskell = {
    formattingProvider = "fourmolu",
}

local servers = {
    tsserver = {},
    pyright = {},
    svelte = {},
    clangd = {},
    hls = {
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        haskell = haskell,
    },
    rust_analyzer = { settings = rust },
}

local function exists(config)
    local binary = config.document_config.default_config.cmd[1]
    return vim.fn.executable(binary) == 1
end

return function(register, attach)
    local onatt = function(client, buffer) register(attach, client, buffer) end
    local opts = { on_attach = onatt }
    func.kv_map(function(kv)
        local server, options = unpack(kv)
        if exists(lsconfig[server]) then
            return lsconfig[server].setup(vim.tbl_extend('error', opts, options))
        end
    end, servers)
end
