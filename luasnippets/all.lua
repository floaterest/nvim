require("util.luasnip")
local symbols = {
	-- logic
	bc = "∵",
	tf = "∴",
	conj = "∧",
	disj = "∨",
	uni = "∀",
	exi = "∃",
	nexi = "∄",
	equiv = "≡",
	neg = "¬",
	ne = "≠",
	-- set theory
	no = "∅",
	["in"] = "∈",
	nin = "∉",
	un = "⋃",
	it = "⋂",
	-- greek
	D = "Δ",
	e = "ε",
	G = "Γ",
	l = "λ",
	P = "Π",
	S = "Σ",
	-- misc
	sqrt = "√",
	inf = "∞",
	bot = "⊥",
}

local snippets = kv_map(function(k, v)
	return s(k, t(v))
end, symbols)

return snippets, {}
