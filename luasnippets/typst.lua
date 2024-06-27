local List = require("plenary.collections.py_list")
require("util.luasnip")

local greek = {
	a = "α",
	b = "β",
	c = "χ",
	d = "δ",
	D = "Δ",
	h = "η",
	g = "γ",
	G = "Γ",
	k = "κ",
	l = "λ",
	L = "Λ",
	m = "μ",
	o = "ω",
	O = "Ω",
	Phi = "Φ",
	p = "π",
	P = "Π",
	x = "ψ",
	X = "Ψ",
	r = "ρ",
	s = "σ",
	S = "Σ",
	t = "τ",
	th = "θ",
	TH = "Θ",
	e = "ε", -- εϵ
	f = "φ",
	z = "ζ",

	-- x = "ξ",
	-- X = "Ξ",
	le = "⩽",
	i = "^(-1)",
	inf = "∞",
	n = "א",
	no = "nothing",
	iff = "<==>",
	st = "★",
    II = "Ⅱ",
    III = "Ⅲ",
    IV = "Ⅳ",
    VI = "Ⅵ",
    VII = "Ⅶ",
    VIII = "Ⅷ",
    IX = "Ⅸ",
    XI = "Ⅺ",
    XII = "Ⅻ",
}

local subs = {
	-- algebra
	-- set
	-- logic
	fo = "∀",
	ex = "∃",
	pm = "±",
    dc = "⋯",
	fi = "f^(-1)",
	gi = "g^(-1)",
	pi = "π^(-1)",
	nex = "∄",
    eqd = "≐",
	lra = "<->",
	im = "==>",
	mi = "<==",
	partial = "∂",
}

local space = {
	semi = "⋉",
	joi = "⋈",
	int = "∫",
	dot = "·",
	lt = "<",
	sp = "space",
	ti = "×",
	psi = "ψ",
	phi = "φ",
    equiv = '\u{2261}',
    nequiv = '\u{2262}',
	bc = "∵",
	bcc = "∵ &&",
	tf = "∴",
	tff = "∴ &&",
	eq = "&=",
	-- logic
	vd = "⊢",
	vD = "⊨",
	nvd = "⊬",
	de = "≝",
	ne = "≠",
	iso = "≅",
	niso = "≇",
	-- set
	-- ['in'] = '∈',
	nin = "∉",
	su = "⊂",
	se = "⊆",
	nse = "⊈",
	es = "⊇",
	sect = "∩",
	un = "∪",
	uq = "⊔",
	le = "⩽",
	ge = "⩾",
	Un = "union.big",
	Se = "sect.big",
	-- typography
	qu = "quad",
	h1 = "#h(1fr)",
}

local commands = {
	"definition",
	"theorem",
	"example",
}

local snip = List.new({
	s("an", fmt("⟨{}⟩", { i(0) })),
}):concat(
	kv_map(function(trig, name)
		return s(trig, t(name))
	end, greek),
	kv_map(function(trig, name)
		return s(trig, t(name))
	end, space),
	kv_map(function(trig, name)
		return s({ trig = "_" .. trig, wordTrig = false }, t("_" .. name))
	end, greek)
)

local auto = List.new({
	-- s("$ ", fmta("$ <> ", { i(0) })),
	s("ol ", fmta("overline(<>)", { i(0) })),
	s("ul ", fmta("underline(<>)", { i(0) })),
	s("\\l ", t("<- ")),
	s({ trig = "\\i ", wordTrig = false }, t("^(-1)")),
	s({ trig = "c(%l) ", regTrig = true }, fmta("cal(<>)", { l(l.CAPTURE1:upper()) })),
	-- s({ trig = "c(%l)(%l) ", regTrig = true }, fmta("cal(<>)(<>)", { l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper()) })),
}):concat(
	kv_map(function(trig, name)
		return s(trig .. " ", t(name))
	end, subs),
	kv_map(function(trig, name)
		return s(trig .. " ", t(name .. " "))
	end, space),
	vim.tbl_map(function(name)
		return s("#" .. name:sub(0, 3) .. " ", fmt("#{}({})[\n{}\n]", { t(name), i(1), i(0) }))
	end, commands)
)

return snip, auto
