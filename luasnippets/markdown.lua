local List = require("plenary.collections.py_list")
require("util.luasnip")

local greek = {
	alpha = "α",
	beta = "β",
	gamma = "γ",
	delta = "δ",
	epsilon = "ε",
	zeta = "ζ",
	eta = "η",
	theta = "θ",
	iota = "ι",
	kappa = "κ",
	lambda = "λ",
	mu = "μ",
	nu = "ν",
	xi = "ξ",
	omicron = "ο",
	pi = "π",
	rho = "ρ",
	sigma = "σ",
	tau = "τ",
	upsilon = "υ",
	phi = "φ",
	chi = "χ",
	psi = "ψ",
	omega = "ω",
}

local snips = {
	details = {
		def = "definition",
		the = "theorem",
		exa = "example",
		alg = "algorithm",
	},
}

local function details(attr)
	local opts = { attr = attr, i(0) }
	return fmt("<details {attr}open>\n<summary>{}</summary>\n\n</details>", opts)
end

local leader = "\\"
local function slead(trig, ...)
	return s({ trig = leader .. trig, wordTrig = false }, ...)
end
local function sleadr(trig, ...)
	return s({ trig = leader .. trig, wordTrig = false, regTrig = true }, ...)
end

local function kv_slead(fun, t)
	return kv_map(function(trig, snip)
		return slead(trig .. " ", fun(snip))
	end, t)
end

local snippets = List.new({
	sleadr("code(%l+)", {
		t('<Code code="'),
		i(0),
		t('" lang="'),
		l(l.CAPTURE1),
		t('"/>'),
	}),
}):concat(
ifmtas(greek)
)

local autosnippets = List.new({
	sleadr("cen ", fmt('<div class="flex justify-center">\n\n{}\n</div>', { i(0) })),
	sleadr("tit ", fmt('<span title="{}"></span>', { i(0) })),
	sleadr("flo ", fmt('<span class="float-right">({})</span>', { i(0) })),
	sleadr("spa ", fmt('<span class="{}"></span>', { i(0) })),
	sleadr("lam ", t("λ")),
	sleadr("div ", fmt('<div class="{}"></div>', { i(0) })),
	-- <details> with optional class
	sleadr(
		"det(%l*) ",
		details(f(function(_, snip)
			local cap = snip.captures[1]
			return cap:len() > 0 and string.format('class="%s" ', cap) or ""
		end))
	),
	slead("pro ", fmt('<details class="list-none" open>\n<summary>**Proof.**</summary>\n\n{}\n</details>', { i(0) })),
	slead("tikz ", fmt("<Tikz>\n{{String.raw`\n{}\n`}}\n</Tikz>", { i(0) })),
}):concat(kv_slead(function(class)
	return details(string.format('class="%s" ', class))
end, snips.details))

return snippets, autosnippets
