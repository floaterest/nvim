local List = require("plenary.collections.py_list")
require("util.luasnip")

local symbols = {
	N = "ℕ",
	l = "λ",
	a = "α",
	["and"] = "∧",
}
local pairs = {
	an = { "⟨", "⟩" },
}
return List.new({}):concat(
	kv_map(function(trig, name)
		return s(trig, t(name))
	end, symbols),
	kv_map(function(trig, sub)
		return s(trig, {
			d(1, function(_, parent)
				return sn(nil, {
					t(sub[1]),
					(#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
					t(sub[2]),
				})
			end),
		})
	end, pairs)
)
