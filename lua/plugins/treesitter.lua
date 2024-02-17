local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

local languages = {
	"astro",
	"bash",
	"c",
	"cpp",
	"css",
	"haskell",
	"html",
	"javascript",
	"jsonc",
	"lua",
	"markdown",
"markdown_inline",
	"python",
	"regex",
	"rust",
	"svelte",
	"toml",
	"typescript",
	"vim",
	"yaml",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = languages,
	highlight = { enable = true },
	playground = { enable = true },
})


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

vim.treesitter.language.register("markdown", "mdx")

-- code folding
vim.o.fdm = "expr"
vim.o.fde = "nvim_treesitter#foldexpr()"
vim.o.fdl = 99
