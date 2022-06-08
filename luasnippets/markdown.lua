local tab = '    '
local leader = '\\'
local lead_trig = function(t) return trig(leader .. t .. ' ') end
local lead_rtrig = function(t) return rtrig(leader .. t .. ' ') end
local details = [[
<details class="{class}"><summary>
</summary>
{}
</details>
]]

local snip = {
    symbols = {
        tf = '∴', bc = '∵', conj = '∧', disj = '∨', exdisj = '⊻', ne = '≠',
        uni = '∀', exi = '∃', nexi = '∄', sqrt = '√', nin = '∉', inf = '∞',
    },
    pairs = { '()', '[]', '||' },
}

local auto = {
    subs = {
        sp = { '\\mathrm{sp}', '\\{\\}' },
        co = { '\\mathrm{col}', '()' },
        ro = { '\\mathrm{row}', '()' },
        nu = '\\mathrm{null}\\,',
        ti = '\\tilde T',
        im = '\\mathrm{im}\\,',
        ra = '\\mathrm{rank}\\,',
        atan = { '\\mathrm{atan}', '()' },
        ob = { '\\overbrace', '{}' },
        ub = { '\\underbrace', '{}' },
        Lvw = '\\mathcal L(V,W)',
        Lv = '\\mathcal L(V)',
        Ln = '\\mathcal L(V^n)',
        M = '\\mathcal M(T)',
        C = '\\mathbb C',

        inv = '^{-1}',
        T = '^T',

        phi = '\\varphi',
        lam = '\\lambda',
        eps = '\\varepsilon',
        tf = '\\therefore&\\,',
        bc = '\\because&\\,',
        qed = '\\quad\\blacksquare',
        st = '\\textsf{ st }',
        ge = '\\geqslant',
        le = '\\leqslant',

        t = { '\\textsf', '{}' },
        f = { '\\frac', '{}' },
        rm = { '\\mathrm', '{}' },
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

return pack({
    {
        s(lead_rtrig('mat([ad]?)(%d) (.+)'), f(mat)),
    },
    map(snip.symbols, function(k,v) return s(k, t(v)) end),
    map(snip.pairs, function(_,v)
        return s(trig(v), fmta('\\left<l><>\\right<r>', { l = v:sub(1,#v/2), r = v:sub(#v/2+1,#v), i(0) }))
    end),
}), pack({
    {
        s('u ', { t('$'), i(0), t('$') }),
        s('uu ', { t('$$'), i(0), t('$$') }),
        s('ud ', { t('$\\displaystyle'), i(0), t('$') }),
        s(lead_rtrig('lim(%l)(%w+)'), fmta('\\lim_{<var>\\to<to>}', {
            var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
        })),
        s(lead_rtrig('sum(%l)1(%w+)'),fmta('\\sum_{<var>=1}^<to>', {
            var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
        })),
        s(lead_rtrig('sum(%l)0(%w+)'),fmta('\\sum_{<var>=0}^<to>', {
            var = l(l.CAPTURE1), to = f(numinf, {}, { user_args = { 2, true } })
        })),
        s(lead_rtrig('(in)(%u)(%w?)(%w?)'), f(field, {}, { user_args = { '\\in' } })),
        s(lead_rtrig('(su)(%u)(%w?)(%w?)'), f(field, {}, { user_args = { '\\sube' } })),
        s(lead_rtrig('int(%l)'), fmta('\\int <>\\,d<var>', { var = l(l.CAPTURE1), i(1) })),
        s(lead_rtrig('int(%w)(%w)(%l)'), fmta('\\int_<a>^<b><>\\,d<var>', {
            a = f(numinf, {}, { user_args = { 1 } }),
            b = f(numinf, {}, { user_args = { 2 } }),
            var = l(l.CAPTURE3), i(1)
        })),
        s(lead_trig('beg'), fmta(('\\begin{<b>}\n%s<>\n\\end{<e>}'):format(tab), {
            b = i(1), e = rep(1), i(0)
        })),
    },
    map(auto.pow, function(_, v) return s(rtrig(v .. ' '), {
        l(l.CAPTURE1), t('^'), l(l.CAPTURE2)
    }) end),
    map(auto.details, function(k, v) return s(lead_trig(k), fmt(details, {
        class = v,
        i(1)
    })) end),
    map(auto.envs, function(k, v) return s(lead_trig(k), fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
        env = v, d(1, function(_, parent)
            local sr = map(parent.env.SELECT_RAW, function(_,line)
                return tostring(line:gsub('^%s+', tab))
            end)
            return sn(nil, #sr > 0 and t(sr) or { t(tab), i(1) })
        end),
    })) end),
    map(auto.subs, function(k, v) return s(lead_trig(k), type(v) == 'string' and t(v) or {
        t(v[1]), d(1, function(_, parent) return sn(nil, {
            t(v[2]:sub(1,#v[2]/2)),
            (#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
            t(v[2]:sub(#v[2]/2+1,#v[2]))
        }) end)})
    end),
})

