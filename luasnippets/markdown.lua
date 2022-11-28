local tab = '  '
local leader = '\\'
local lead_trig = function(t) return trig(leader .. t .. ' ') end
local lead_rtrig = function(t) return rtrig(leader .. t .. ' ') end
local details = '<details class="{class}" open>\n<summary>{}</summary>\n</details>'

local snip = {
    symbols = {
        bc = '∵', conj = '∧', disj = '∨', exi = '∃', inf = '∞',
        ne = '≠', nexi = '∄', nin = '∉', sqrt = '√', tf = '∴',  uni = '∀',
        un = '⋃', it = '⋂', eps = 'ε', neg = '¬', ['in'] = '∈',
    },
    pairs = { '()', '[]', '||' },
}

local auto = {
    subs = {
		no = '\\varnothing',
        Sa = '\\Sigma^\\ast',
        Ga = '\\Gamma^\\ast',
        ha = '\\htmlClass{accent}',
        a = '^\\ast',
        S = '\\Sigma',
        G = '\\Gamma',

        p = '\\varphi',
        d = '\\delta',
        l = '\\lambda',
        q = '\\quad',
        en = '\\enspace',
        e = '\\varepsilon',
        tf = '\\therefore',
        bc = '\\because',
        tff = '&\\therefore',
        bcc = '&\\because',
        qed = '\\quad\\blacksquare',
        ex = '\\exists',

        st = '\\textsf{ st }',
        i = '^{-1}',
        t = { '\\textsf', '{', '}' },
		g = { '\\tag', '{\\sf ', '}' },
        f = { '\\frac', '{', '}' },
        im = '\\implies',
        rm = { '\\mathrm', '{', '}' },
        atan = { '\\mathrm{atan}', '(', ')' },
        ob = { '\\overbrace', '{', '}' },
        ub = { '\\underbrace', '{', '}' },
        ol = '\\overline '
    },
    details = {
        def = 'definition', the = 'theorem', exa = 'example', alg = 'algorithm',
    },
    envs = {
        al = 'align*', ca = 'cases', ga = 'gather*', ar = 'array',
        pm = 'pmatrix', bm = 'bmatrix', vm = 'vmatrix',
    },
    pow = { '([%)|])(%d)', '(%A%a)(%d)' },
}

local function mat(_, snip)
    -- v for vertical bars (determinant)
    local cnt = tonumber(snip.captures[2])
    local env = snip.captures[1] == 'v' and 'vmatrix' or 'pmatrix'
    -- snip.captures[1] == 'a' and ('c'):rep(cnt - 1) .. '|c' or ('c'):rep(cnt)
    local content = { '\\begin{' .. env .. '}' }

    local i, line = 1, ''
    for s in snip.captures[3]:gmatch('%S+') do
        if i % cnt == 0 then
            content[#content + 1] = line .. s .. '\\\\'
            line = ''
        else
            line = line .. s .. '&'
        end
        i = i + 1
    end
    content[#content + 1] = '\\end{' .. env .. '}'
    return table.concat(content, '')
end

local function numinf(_, snip, cap, space)
    local s = snip.captures[cap]:gsub('f$', '\\infty')
    if s:len() > 1 then
        s = '{' .. s .. '}'
    end
    return (s:match('^%a') and space) and (' ' .. s) or s
end

local function partial(_, snip, cap)
    local s = snip.captures[cap]
    local t = snip.captures[cap + 1]
    -- if numerator
    if t then
        local len = t:len()
        return (len == 1 and '\\partial ' or '\\partial^' .. len) .. s
    else
        return s:gsub('(%d)', '^%1'):gsub('(%l)', '\\partial %1')
    end
end

return pack({
    {
        s(lead_rtrig('(v?)mat(%d) (.+)'), f(mat)),
        s(lead_rtrig('int (.+) (.+) (.+)'), fmta('\\int_<a>^<b><>\\,d<var>', {
            a = f(numinf, {}, { user_args = { 1 } }),
            b = f(numinf, {}, { user_args = { 2 } }),
            var = l(l.CAPTURE3), i(1)
        })),
    },
    map(snip.symbols, function(k,v) return s(k, t(v)) end),
    map(snip.pairs, function(_,v)
        return s(trig(v), fmta('\\left<l><>\\right<r>', {
            l = v:sub(1,#v/2),
            r = v:sub(#v/2+1,#v), i(0)
        }))
    end),
}), pack({
    {
        s('u ', { t('$'), i(0), t('$') }),
        s('uu ', { t('$$'), i(0), t('$$') }),
        s('ud ', { t('$\\displaystyle'), i(0), t('$') }),
        s(lead_rtrig('det(%l*)'), fmt('<details {}open><summary>{}</summary>\n</details>',{
            f(function(_, snip)
                local cap = snip.captures[1]
                return cap:len() > 0 and string.format('class="%s" ', cap) or ''
            end, {}),
            i(0)
        })),
        s(lead_rtrig('lim(%l)(%w+)'), fmta('\\lim_{<var>\\to<to>}', {
            var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
        })),
        s(lead_rtrig('sum(%l)(%d)(%w+)'),fmta('\\sum_{<var>=<a>}^<b>', {
            var = l(l.CAPTURE1),
            a = l(l.CAPTURE2),
            b = f(numinf, {}, { user_args = { 3, true } })
        })),
        s(lead_rtrig('cal(%l+)'), fmta('\\mathcal <>',{ l(l.CAPTURE1:upper()) })),
        s(lead_rtrig('bb(%l+)'), fmta('\\mathbb <>',{ l(l.CAPTURE1:upper()) })),
        s(lead_rtrig('(d?)par([^t])(%w+)'), fmta('\\<>frac{<>}{<>}', {
            l(l.CAPTURE1),
            f(partial, {}, { user_args = { 2 } }),
            f(partial, {}, { user_args = { 3 } }),
        })),
        s(lead_rtrig('der(%l)(%l)'), fmta('\\frac{d<>}{d<>}', { l(l.CAPTURE1), l(l.CAPTURE2) })),
        s(lead_rtrig('int(%l)'), fmta('\\int <>\\,d<var>', { var = l(l.CAPTURE1), i(1) })),
        s(lead_trig('beg'), fmta(('\\begin{<b>}\n%s<>\n\\end{<e>}'):format(tab), {
            b = i(1), e = rep(1), i(0)
        })),
    },
    map(auto.pow, function(_, v)
        return s(rtrig(v .. ' '), { l(l.CAPTURE1), t('^'), l(l.CAPTURE2) })
    end),
    map(auto.details, function(k, v)
        return s(lead_trig(k), fmt(details, { class = v, i(1) }))
    end),
    map(auto.envs, function(k, v)
        return s(lead_trig(k), fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
            env = v, d(1, function(_, parent)
                local sr = map(parent.env.SELECT_RAW, function(_,line)
					return tostring(line:gsub('^[%s%$]*', tab):gsub('[%s%$]*$', ''))
                end)
                return sn(nil, #sr > 0 and t(sr) or { t(tab), i(1) })
            end),
        }))
    end),
    map(auto.subs, function(k, v)
        return s(lead_trig(k), type(v) == 'string' and t(v) or {
            t(v[1]),
            d(1, function(_, parent) return sn(nil, {
                t(v[2]),
                (#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
                t(v[3])
            }) end)
        })
    end),
})

