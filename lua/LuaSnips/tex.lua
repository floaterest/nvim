local luasnip = require('luasnip')
local s = luasnip.snippet
local sn = luasnip.snippet_node
local d = luasnip.dynamic_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local l = require('luasnip.extras').lambda
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local u = require((...):match('^%w+') .. '.utils')

local tab = '    '
local leader = '\\'
local trig = function(t) return u.trig(leader .. t .. ' ') end
local rtrig = function(t) return u.rtrig(leader .. t .. ' ') end

local snip = {
    pairs = { '()', '[]' }
}

local auto = {
    subs = {
		sp = { '\\mathrm{sp}', '\\{\\}' },
		di = { '\\mathrm{dim}', '()' },
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
    envs = {
        al = 'align*', it = 'itemize', en = 'enumerate', ca = 'cases', ga = 'gather*',
		ar = 'array',
        -- from preamble
        def = 'definition', the = 'theorem', exa = 'example', alg = 'algorithm',
    },
    accents = {
        bar = 'overline'
    },
	pow = { '([%)|])(%d)', '(%A%a)(%d)' },
}

local function field(_, snip, cmd)
	local res = snip.captures[2]
	res = res:match('[CNQRZ]') and ('\\mathbb{%s}'):format(res) or ' ' .. res
	if(snip.captures[4] ~= '') then
		res = ('%s^{%s\\times %s}'):format(res, snip.captures[3], snip.captures[4])
	elseif(snip.captures[3] ~= '') then
		res = ('%s^%s'):format(res, snip.captures[3])
	end
	return snip.captures[1] == '' and res:gsub('^%s+', '') or cmd .. res
end

local function mat(_, snip) -- 'mat([ad]?)(%d) (.+)'
	-- from preamble
	-- a for augmented
	-- v for vertical bars (determinant)
	local cnt = tonumber(snip.captures[2])
	local env = snip.captures[1] == 'v' and 'vmat' or 'mat'
	local content = {
		'\\begin{' .. env .. '}{' .. (
			snip.captures[1] == 'a' and ('c'):rep(cnt - 1) .. '|c' or ('c'):rep(cnt)
		) .. '}'
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

return {
    snippets = u.pack({
        {
			s('init', fmta([[
				\input{preamble}
				\title{<title>}
				\begin{document}
				\maketitle\tableofcontents

				<>

				\end{document}
			]],{ title = i(1, 'Title'), i(0) })),
            s(rtrig('mat([ad]?)(%d) (.+)'), f(mat)),
        },
        u.map(snip.pairs, function(_, v)
			return s(u.trig(v), fmta('\\left<l><>\\right<r>', {
				l = v:sub(1,1), r = v:sub(2,2), i(0) 
			}))
        end),
    }),
    autosnippets = u.pack({
        {
            s('u ', { t('$'), i(0), t('$') }),
            s('uu ', { t('$$'), i(0), t('$$') }),
			s('ud ', { t('$\\displaystyle'), i(0), t('$') }),
    
			s(rtrig('v(%l)'), fmta('\\vec <var>', { var = l(l.CAPTURE1) })),
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
			s(rtrig('lim(%l)(%w+)'), fmta('\\lim_{<var>\\to<to>}', {
				var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
			})),
		},
		u.map(auto.pow, function(_, v) return s(u.rtrig(v .. ' '), {
			l(l.CAPTURE1), t('^'), l(l.CAPTURE2) 
		}) end),
        u.map(auto.subs, function(k, v) return s(trig(k), type(v) == 'string' and t(v) or {
			t(v[1]), d(1, function(_, parent) return sn(nil, {
				t(v[2]:sub(1,#v[2]/2)),
				(#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
				t(v[2]:sub(#v[2]/2+1,#v[2]))
			}) end)})
        end),
		u.map(auto.envs, function(k, v) return s(trig(k), fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
		    env = v, d(1, function(_, parent)
				local sr = u.map(parent.env.SELECT_RAW, function(_,line)
					return tostring(line:gsub('^%s+', tab))
				end)
				return sn(nil, #sr > 0 and t(sr) or { t(tab), i(1) })
			end),
		})) end),
        u.map(auto.accents, function(k, v) return s(rtrig(k .. '(%w)'), {
			t(('\\%s '):format(v)), l(l.CAPTURE1)
		}) end),
    }),
}
