local luasnip = require("luasnip")
local func = require("plenary.functional")

s = luasnip.s
sn = luasnip.snippet_node
t = luasnip.t
i = luasnip.i
f = require("luasnip.nodes.functionNode").F
d = require("luasnip.nodes.dynamicNode").D
l = require("luasnip.extras").lambda
rep = require("luasnip.extras").rep

local FMT = require("luasnip.extras.fmt").fmt
local FMTA = require("luasnip.extras.fmt").fmta
local function fopts(opts)
	return vim.tbl_extend("keep", opts or {}, { repeat_duplicates = true })
end

function fmt(format, nodes, opts)
	return FMT(format, nodes, fopts(opts))
end
function fmta(format, nodes, opts)
	return FMTA(format, nodes, fopts(opts))
end

function kv_map(fun, t)
	return func.kv_map(function(kv)
		return fun(unpack(kv))
	end, t)
end

local function iformat(delim)
	return func.partial(kv_map, function(trig, templ)
		-- return snippet with each delimiter replaced by insert node
		local _, n = templ:gsub(delim, "")
		local option = {}
		for index = 1, n do
			-- last index will be 0
			option[index] = i(index % n)
		end
		return s(trig, fmt(templ, option, { delimiters = delim }))
	end)
end

ifmtas = iformat("<>")
ifmts = iformat("{}")

return setfenv(2, _G)
