require("colo")
require("autocmd")
require("options")
require("plugins")

-- see log in ~/.local/state/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

if vim.g.neovide then
	require("neovide")
end


-- treesitter

local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

local function hasgrandparent(match, _, _, predicate)
	local node = match[predicate[2]]
	for _ = 1, 2 do
		if not node then
			return false
		end
		node = node:parent()
	end
	if not node then
		return false
	end
	local ancestor_types = { unpack(predicate, 3) }
	if vim.tbl_contains(ancestor_types, node:type()) then
		return true
	end
	return false
end

local function setpairs(match, _, source, predicate, metadata)
	-- (#set-pairs! @aa key list)
	local capture_id = predicate[2]
	local node = match[capture_id]
	local key = predicate[3]
	if not node then
		return
	end
	local node_text = vim.treesitter.get_node_text(node, source)
	for i = 4, #predicate, 2 do
		if node_text == predicate[i] then
			metadata[key] = predicate[i + 1]
			break
		end
	end
end

vim.treesitter.query.add_predicate("has-grandparent?", hasgrandparent, true)
vim.treesitter.query.add_directive("set-pairs!", setpairs, true)

local filenames = {
	unpack(vim.treesitter.query.get_files("latex", "highlights")),
	unpack(vim.api.nvim_get_runtime_file("queries/latex/*.scm", true)),
}

-- make query
local query = table.concat(
	vim.tbl_map(function(f)
		return with(open(f), function(r)
			return r:read("*a")
		end)
	end, filenames), "\n\n"
)

-- add custom symbols
local symbols = {
	because = "∵",
	therefore = "∴",
	implies = "⇒",
	enspace = " ",
	square = "□",
	["{"] = "{",
	["}"] = "}",
}

local qa = [[(generic_command
  command: ((command_name) @text.math
  (#any-of? @text.math]]
local qb = [[))
  (#set-pairs! @text.math conceal]]

for command, symbol in pairs(symbols) do
	qa = qa .. '\n    "\\\\' .. command .. '" '
    qb = qb .. '\n    "\\\\' .. command .. '" "' .. symbol .. '" '
end

query = query .. qa .. qb .. '))'

vim.treesitter.query.set("latex", "highlights", query)


