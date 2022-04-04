local luasnip = require('luasnip')
local s = luasnip.snippet
local sn = luasnip.snippet_node
local d = luasnip.dynamic_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local l = require('luasnip.extras').lambda
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local u = require((...):match('^%w+') .. '.utils')
local tab = '    '
local leader = '\\'
local trig = function(t) return u.trig(leader .. t .. ' ') end
local rtrig = function(t) return u.rtrig(leader .. t .. ' ') end
local details = [[
<details class="{class}" open><summary>
</summary>
{}
</details>
]]

local snip = {
	words = {
		conc = 'conclusion', infl = 'influence', proc = 'process', expl = 'explain',
	},
	html = {
		div = { '<div class="', '"></div>'},
		quote = { '<blockquote>', '</blockquote>' },
		span = { '<span class="', '"></span>'},
		details = { '<details><summary>', '</summary></details>' }
	},
    symbols = {
        tf = '∴', bc = '∵', conj = '∧', disj = '∨', exdisj = '⊻', neg = '¬',
        uni = '∀', exi = '∃', nexi = '∄', Rarr = '⇒', rarr = '→',
		inf = '∞', ne = '≠', nin = '∉',
    },
	pairs = { '()', '[]', '||' },
}

local auto = {
	--[[
    words = {
		k = 'knowledge', K = 'Knowledge',
        t = 'the', f = 'for', b = 'but', n = 'and', w = 'with', o = 'not',
		r = 'are', u  = 'use', c = 'can',

        fr = 'from', bf = 'before', tt = 'that', ab = 'about', bt = 'between', 
        wt = 'what', tr = 'there', wo = 'without', wc = 'which', wr = 'where', 
        ch = 'change', mo = 'more', su = 'such', mu = 'much', ts = 'this',
		ov = 'over', wn = 'when', ot = 'other', anot = 'another', bo = 'both',
		hv = 'have', mv = 'move', wi = 'within', sm = 'same', 
		md = 'made', mk = 'make', rm = 'remove', ud = 'under',
    },
    suffixes = { M = 'ment', I = 'ing', T = 'tion', S = 'sion', L = 'less' },
	]]--
    subs = {
		sp = { '\\mathrm{span}', '\\{\\}' },
		co = { '\\mathrm{col}', '()' },
		ro = { '\\mathrm{row}', '()' },
		nu = { '\\mathrm{null}', '()' },
		ke = { '\\mathrm{ker}', '()' },
		im = { '\\mathrm{im}', '()' },
		di = { '\\mathrm{dim}', '()' },
		ra = { '\\mathrm{rank}', '()' },
		atan = { '\\mathrm{atan}', '()' },

        inv = '^{-1}',
        T = '^T',

        phi = '\\varphi',
		lam = '\\lambda',
		eps = '\\varepsilon',
        tf = '\\therefore',
        bc = '\\because',
		rarr = '\\rightarrow',
		Rarr = '\\Rightarrow',
        qed = '\\quad\\blacksquare',

		cc = '\\color{\\colo}',
		tcc = '\\textcolor{\\colo}',

        t = { '\\text', '{}' },
		f = { '\\frac', '{}' },
		rm = { '\\mathrm', '{}' },
        tc = { '\\textcolor', '{}' },
        bf = { '\\textbf', '{}', },
        sec = { '\\section', '{}', },
        ssec = { '\\subsection', '{}', },
        sssec = { '\\subsubsection', '{}' },
    },
	details = {
    	def = 'definition', the = 'theorem', exa = 'example', alg = 'algorithm',
	},
	envs = {
        al = 'align*', ca = 'cases', ga = 'gather*', ar = 'array',
	},
	pow = { '([%)|])(%d)', '(%A%a)(%d)' },
}

local function field(_, snip, cmd)
	local res = snip.captures[2]
	res = res:match('[CNQRZ]') and ('\\%s'):format(res) or ' ' .. res
	if(snip.captures[4] ~= '') then
		res = ('%s^{%s\\times %s}'):format(res, snip.captures[3], snip.captures[4])
	elseif(snip.captures[3] ~= '') then
		res = ('%s^%s'):format(res, snip.captures[3])
	end
	return snip.captures[1] == '' and res:gsub('^%s+', '') or cmd .. res
end

local function mat(_, snip) -- 'mat([av]?)(%d) (.+)'
	-- from preamble
	-- a for augmented
	-- v for vertical bars (determinant)
	local cnt = tonumber(snip.captures[2])
	local env = snip.captures[1] == 'v' and 'vmatrix' or 'bmatrix'
	-- snip.captures[1] == 'a' and ('c'):rep(cnt - 1) .. '|c' or ('c'):rep(cnt)
	local content = {
		'\\begin{' .. env .. '}'
	}

	local i, line = 1, ''
	for s in snip.captures[3]:gmatch('%S+') do
		if i % cnt == 0 then
			content[#content + 1] = tab .. line .. s .. '\\\\'
			line = ''
		else
			line = line .. s .. '&'
		end
		i = i + 1
	end
	content[#content + 1] = '\\end{' .. env .. '}'
	return content
end

local function numinf(_, snip, ncap, space)
	local cap = snip.captures[ncap]:gsub('^f$', '\\infty')
	return (cap:match('^%a') and space) and (' ' .. cap) or cap
end

local function vec(_, snip)
	local name = snip.captures[1];
	local sub = snip.captures[2];
	return (name:match('%d') and '\\vec' or '\\vec ') .. name .. (sub == '' and '' or '_' .. sub)
end

return {
    snippets = u.pack({
		{
            s(rtrig('mat([ad]?)(%d) (.+)'), f(mat)),
		},
		u.map(snip.symbols, function(k,v) return s(k, t(v)) end),
		u.map(snip.html, function(k,v) return s(k,{ t(v[1]), i(0), t(v[2]) }) end),
		u.map(snip.pairs, function(_,v)
			return s(u.trig(v), fmta('\\left<l><>\\right<r>', { l = v:sub(1,#v/2), r = v:sub(#v/2+1,#v), i(0) }))
		end),
    }),
    autosnippets = u.pack({
		{
			s('u ', { t('$'), i(0), t('$') }),
			s('uu ', { t('$$'), i(0), t('$$') }),
			s('ud ', { t('$\\displaystyle'), i(0), t('$') }),
			s(rtrig('v(%l)([i%d]?)'), f(vec)),
			s(rtrig('lim(%l)(%w+)'), fmta('\\lim_{<var>\\to<to>}', {
				var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
			})),
			s(rtrig('sum(%l)1(%w+)'),fmta('\\sum_{<var>=1}^<to>', {
				var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
			})),
			s(rtrig('sum(%l)0(%w+)'),fmta('\\sum_{<var>=0}^<to>', {
				var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
			})),
            s(rtrig('(i?n?)(%u)(%w?)(%w?)'), f(field, {}, { user_args = { '\\in' } })),
            s(rtrig('(su)(%u)(%w?)(%w?)'), f(field, {}, { user_args = { '\\subseteq' } })),
            s(rtrig('int(%l)'), fmta('\\int <>\\,d<var>', { var = l(l.CAPTURE1), i(1) })),
			s(rtrig('int(%w)(%w)(%l)'), fmta('\\int_<a>^<b><>\\,d<var>', {
				a = f(numinf, {}, { user_args = { 1 } }),
				b = f(numinf, {}, { user_args = { 2 } }),
				var = l(l.CAPTURE3), i(1)
			})),
			s(trig('beg'), fmta(('\\begin{<b>}\n%s<>\n\\end{<e>}'):format(tab), {
			    b = i(1), e = rep(1), i(0)
			})),
		},
		u.map(auto.pow, function(_, v) return s(u.rtrig(v .. ' '), {
			l(l.CAPTURE1), t('^'), l(l.CAPTURE2)
		}) end),
		u.map(auto.details, function(k, v) return s(trig(k), fmt(details, {
			class = v,
			i(1)
			-- d(1, function(_, parent)
			-- 	local raw = u.map(parent.env.SELECT_RAW, function(_, line)
			-- 		return tostring(line:gsub('^%s+', tab))
			-- 	end)
			-- 	return sn(nil, #raw > 0 and t(raw) or { t(tab), i(1) })
			-- end),
		})) end),
		u.map(auto.envs, function(k, v) return s(trig(k), fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
		    env = v, d(1, function(_, parent)
				local sr = u.map(parent.env.SELECT_RAW, function(_,line)
					return tostring(line:gsub('^%s+', tab))
				end)
				return sn(nil, #sr > 0 and t(sr) or { t(tab), i(1) })
			end),
		})) end),
        u.map(auto.subs, function(k, v) return s(trig(k), type(v) == 'string' and t(v) or {
			t(v[1]), d(1, function(_, parent) return sn(nil, {
				t(v[2]:sub(1,#v[2]/2)),
				(#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
				t(v[2]:sub(#v[2]/2+1,#v[2]))
			}) end)})
        end),
    }),
}
