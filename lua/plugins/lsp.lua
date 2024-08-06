-- local lua = {
--     runtime = { version = 'LuaJIT' },
--     diagnostics = { globals = { 'vim' } },
--     telemetry = { enable = false },
-- }

local rust = {
    ['rust-analyzer'] = {
        diagnostics = { disabled = { 'inactive-code' } },
    },
}

local haskell = {
    formattingProvider = "fourmolu",
    -- plugin = {
    -- 	["hls-hlint-plugin"] = { globalOn = true },
    -- 	["hls-fourmolu-plugin"] = { globalOn = true },
    -- 	["hls-semantic-tokens-plugin"] = { globalOn = true },
    -- },
}

local servers = {
    tsserver = {},
    pyright = {},
    svelte = {},
    typst_lsp = {},
    racket_langserver = {},
    -- clangd = {},
    hls = { haskell = haskell },
    rust_analyzer = { settings = rust },
}
local function exists(config)
    -- check if binary exists
    local binary = config.document_config.default_config.cmd[1]
    return vim.fn.executable(binary) == 1
end

local lsconfig = require('lspconfig')
for server, options in pairs(servers) do
    if exists(lsconfig[server]) then
        lsconfig[server].setup(options)
    end
end
