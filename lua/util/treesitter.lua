-- write latex treesitter query
local context_manager = require("plenary.context_manager")
local with = context_manager.with
local open = context_manager.open

local func = require("plenary.functional")

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

-- convert table tbl to expression
local function expr(tbl)
	local function e(indent, t)
		if type(t) == "string" then
			return t
		end
		local s = table.concat(vim.tbl_map(func.partial(e, indent + 1), t), "\n" .. string.rep("  ", indent))
		return "(" .. s .. ")"
	end
	return e(1, tbl) .. "\n\n"
end

local function write()
	local latex = require("util.latex")
	local file = vim.fn.stdpath("config") .. "/after/queries/latex/highlights.scm"
	-- local file = "/tmp/file.clj"
	with(open(file, "w"), function(w)
		w:write("; extends\n\n")
		w:write(";; misc\n")
		w:write(table.concat(vim.tbl_map(expr, latex.misc)))
		w:write(";; greek\n")
		w:write(expr(latex.greek))
		w:write(";; operators\n")
		w:write(expr(latex.operators))
		w:write(";; symbols\n")
		w:write(expr(latex.symbols))
		w:write(";; delimiters\n")
		w:write(table.concat(vim.tbl_map(expr, latex.delimiters)))
		w:write(";; typography\n")
		w:write(expr(latex.typography))
		w:write(";; scripts\n")
		w:write(expr(latex.scripts))
		w:write(";; subscripts\n")
		for _, t in ipairs(latex.subscripts) do
			w:write(expr(t))
		end
		w:write(";; superscripts\n")
		for _, t in ipairs(latex.supscripts) do
			w:write(expr(t))
		end
	end)
	print("Queries wrote to " .. file)
end

return function()
	vim.api.nvim_create_user_command("LatexQueryUpdate", write, {})
end
