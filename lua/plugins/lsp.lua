-- local lua = {
--     runtime = { version = 'LuaJIT' },
--     diagnostics = { globals = { 'vim' } },
--     telemetry = { enable = false },
-- }

local rust = {
	["rust-analyzer"] = {
		diagnostics = { disabled = { "inactive-code" } },
	},
}

local haskell = {
	formattingProvider = "fourmolu",
	plugin = {
		["hls-hlint-plugin"] = { globalOn = true },
		['hls-fourmolu-plugin'] = { globalOn= true}
	},
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

return function()
	local func = require("plenary.functional")
	local lsconfig = require("lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities.offsetEncoding = 'utf-8'
	-- lsconfig.clangd.setup({ capabilities = capabilities })

	for server, options in pairs(servers) do
		if exists(lsconfig[server]) then
			lsconfig[server].setup(options)
		end
	end

	-- return function(register, attach)
	-- 	local onatt = function(client, buffer)
	-- 		register(attach, client, buffer)
	-- 	end
	-- 	local opts = { on_attach = onatt }
	-- end
end
