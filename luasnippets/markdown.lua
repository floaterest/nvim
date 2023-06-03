local List = require('plenary.collections.py_list')
require('util.luasnip')

local snips = {
    symbols = {
        bc = '∵', conj = '∧', disj = '∨', exi = '∃', inf = '∞',
        ne = '≠', nexi = '∄', nin = '∉', sqrt = '√', tf = '∴',  uni = '∀',
        un = '⋃', it = '⋂', eps = 'ε', neg = '¬', ['in'] = '∈',
    },
    pairs = { '()', '[]', '||' },
}

local autos = {
    subs = {
        -- Linear Algebra
        ch = '\\textrm{char}',
        sp = '\\operatorname{sp}',
        ra = '\\operatorname{ran}',
        si = '\\operatorname{sign}',
        pe = '^\\perp',
        s = '\\sigma',
        -- ['in'] = '\\textrm{inv }',

        -- Theory of Computation
		no = '\\varnothing',
        Sa = '\\Sigma^\\ast',
        Ga = '\\Gamma^\\ast',
        mi = '_\\mathrm{min}',
        a = '^*',
        an = { '', '\\langle ', '\\rangle' },


        -- Calculus
        di = '\\textrm{div }',
        cu = '\\textrm{curl }',
        o = '\\omega',
        W = '\\bigwedge',
        w = '\\wedge',

        p = '\\varphi', d = '\\delta', l = '\\lambda', e = '\\varepsilon',
        S = '\\Sigma', G = '\\Gamma', P = '\\Phi',

        q = '\\quad', en = '\\enspace',

        tf = '\\therefore', bc = '\\because',
        tF = '\\therefore&&', bC = '\\because&&',
        tff = '\\therefore\\,&', bcc = '\\because\\,&',

        fo = '\\forall', ex = '\\exists',

        qed = '\\quad\\square',

        st = '\\textsf{ st }',
        tt = { '\\texttt', '{', '}' },
        t = { '\\textsf', '{', '}' },
        i = '^{-1}',
		g = { '\\tag', '{\\sf', '}' },
        f = { '\\frac', '{', '}' },
        im = '\\implies',
        rm = { '\\mathrm', '{', '}' },
        atan = { '\\mathrm{atan}', '(', ')' },
        ob = { '\\overbrace', '{', '}' },
        ub = { '\\underbrace', '{', '}' },
        ol = '\\overline',
        ul = {'\\underline '},
    },
    details = {
        def = 'definition', the = 'theorem', exa = 'example', alg = 'algorithm',
    },
    envs = {
        al = 'align*', ca = 'cases', ga = 'gather*', ar = 'array',
    },
}

local function mat(_, snip)
    -- v for vertical bars (determinant)
    local columns = tonumber(snip.captures[2])
    local env = snip.captures[1] == 'v' and 'vmatrix' or 'pmatrix'
    local content = { '\\begin{' .. env .. '}' }
    local i, line = 1, ''
    -- for each space-separated tokens
    for s in snip.captures[3]:gmatch('%S+') do
        if i % columns == 0 then
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

local function partial(n) return f(function(_, snip)
    -- partial derivative
    local a = snip.captures[n]
    local b = snip.captures[n + 1]
    -- if numerator
    if b then
        return (b:len() == 1 and '\\partial ' or '\\partial^' .. b:len()) .. a
    else
        return a:gsub('(%d)', '^%1'):gsub('(%l)', '\\partial %1')
    end
end) end

local function numinf(n, space) return f(function(_, snip)
    -- num to num, f to infty
    local s = snip.captures[n]:gsub('^f$', '\\infty')
    if s:len() ~= 1 and not s:match('^\\') then
        s = '{' .. s .. '}'
    end
    return (space and s:match('^%a')) and ' ' .. s or s
end) end

local function details(attr)
    local opts = { attr = attr, i(0) }
    return fmt('<details {attr}open>\n<summary>{}</summary>\n</details>', opts)
end

local leader = '\\'
local function sw(trig, ...)
    return s({ trig = trig, wordTrig = false }, ...)
end
local function slead(trig, ...)
    return s({ trig = leader .. trig, wordTrig = false }, ...)
end
local function sleadr(trig, ...)
    return s({ trig = leader .. trig, wordTrig = false, regTrig = true }, ...)
end

local function kv_slead(fun, t)
    return kv_map(function(trig, snip)
        return slead(trig .. ' ', fun(snip))
    end, t)
end

local snippets = List.new({
    -- v for determinant, %d for column count
    sleadr('(v?)mat(%d) (.+)', f(mat)),
    sleadr('code(%l+)', {
        t('<Code code="'), i(0), t('" lang="'), l(l.CAPTURE1), t('"/>')
    }),
}):concat(
    kv_map(function(k, v) return s(k, t(v)) end, snips.symbols),
    vim.tbl_map(function(pair)
        return sw(pair, fmt('\\left{l}{}\\right{r}', {
            l = pair:sub(1, #pair/2), r = pair:sub(#pair/2+1, #pair), i(0)
        }))
    end, snips.pairs)
)

local autosnippets = List.new({
    sleadr('bb(%l) ', fmt('\\mathbb {}', { l(l.CAPTURE1:upper()) })),
    sleadr('bb(%l)(%S) ', fmt('\\mathbb {}^{}', {
        l(l.CAPTURE1:upper()), l(l.CAPTURE2)
    })),
    sleadr('cal(%l) ', fmt('\\mathcal {}', { l(l.CAPTURE1:upper()) })),
    sleadr('cal(%l)(.) ', fmta('\\mathcal <>(<>)', {
        l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper())
    })),
    sleadr('cal(%l)(.)(.)', fmta('\\mathcal <>(<>,<>)', {
        l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper()), l(l.CAPTURE3:upper())
    })),
    sleadr('lim(%l)(%S+) ', fmta('\\lim_{<x>\\to<to>}', {
        x = l(l.CAPTURE1), to = numinf(2, true)
    })),
    -- derivative in Leibniz's notation
    sleadr('der(%l)(%l)', fmta('\\frac{d<>}{d<>}', {
        l(l.CAPTURE1), l(l.CAPTURE2)
    })),
    -- partial derivative
    sleadr('(d?)par([^t])(%w+) ', fmta('\\<>frac{<>}{<>}', {
        l(l.CAPTURE1), partial(2), partial(3)
    })),
    sleadr('sum(%l)(%d)(%w+) ', fmta('\\sum_{<i>=<a>}^<b>', {
        i = l(l.CAPTURE1), a = l(l.CAPTURE2), b = numinf(3)
    })),
    sleadr('int(%l) ', fmt('\\int{}\\,d{x}', { x = l(l.CAPTURE1), i(0)})),
    sleadr('int (%S+) (%S+) (%S+) ', fmt('\\int_{a}^{b}{}\\,d{var}', {
        a = numinf(1), b = numinf(2), i(0), var = l(l.CAPTURE3)
    })),
    -- <details> with optional class
    sleadr('det(%l*) ', details(f(function(_, snip)
        local cap = snip.captures[1]
        return cap:len() > 0 and string.format('class="%s" ', cap) or ''
    end))),
}):concat(
    kv_slead(function(class)
        return details(string.format('class="%s" ', class))
    end, autos.details),
    ifmtas({
        ['u '] = '$<>$', ['uu '] = '$$\n<>\n$$', ['ud '] = '$\\displaystyle<>$',
    }),
    kv_slead(function(env) return fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
        env = t(env), d(1, function(_, parent)
            local raw = vim.tbl_map(function(_, line)
                return tostring(line:gsub('^%$+', ''))
            end, parent.env.SELECT_RAW)
            return sn(nil, #raw > 0 and t(raw) or { t('\t'), i(1) })
        end)
    }) end, autos.envs),
    kv_slead(function(sub) return type(sub) == 'string' and t(sub) or {
        t(sub[1]),
        d(1, function(_, parent) return sn(nil, {
            t(sub[2]),
            (#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
            t(sub[3])
        }) end)
    } end,autos.subs)
)

return snippets, autosnippets
