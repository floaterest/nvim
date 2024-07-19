local List = require('plenary.collections.py_list')
require('util.luasnip')

local commands = {
    -- set theory
    inj = '\\hookrightarrow',
    surj = '\\twoheadrightarrow',
    res = '\\upharpoonright',
    bij = '\\stackrel\\sim\\to',
    no = '\\varnothing',
    ti = '\\times',
    c = '^\\circ',
    U = '\\bigcup',
    r = '\\to',
    I = '\\bigcap',
    se = '\\subseteq',
    es = '\\supseteq',
    n = '\\aleph_',
    su = '\\subset',
    dom = '\\operatorname{dom}',
    ran = '\\operatorname{ran}',
    -- algebra
    ch = '\\operatorname{char}',
    cl = '\\operatorname{cl}',
    tr = '\\triangleleft',
    lcm = '\\operatorname{lcm}',
    op = '\\oplus',
    pr = '\\operatorname{Pr}',
    -- analysis
    ['8'] = '\\infty',
    rr = '\\rightrightarrows ',
    -- computation
    Sa = '\\Sigma^\\ast',
    B = '\\{0,1\\}',
    Ga = '\\Gamma^\\ast',
    an = { '', '\\langle ', '\\rangle' },
    fl = { '', '\\lfloor', '\\rfloor' },
    -- proof
    tf = '\\therefore',
    bc = '\\because',
    tF = '\\therefore&&',
    bC = '\\because&&',
    ibc = '\\item[$\\because$]',
    itf = '\\item[$\\therefore$]',
    qed = '\\enspace\\square',
    f = { '\\frac', '{', '}' },
    im = '\\implies',
    mi = '\\impliedby',
    i = '^{-1}',
    fo = '\\forall',
    ex = '\\exists',
    -- typography
    h = { '\\hfill', '(', ')' },
    eq = ' &= ',
    q = '\\quad',
    de = '\\stackrel{\\text{def}}=',
    en = '\\enspace',
    st = '\\text{ st }',
    t = { '\\text', '{', '}' },
    tt = { '\\texttt', '{', '}' },
    bf = { '\\textbf', '{', '}' },
    g = { '\\tag', '{', '}' },
    ob = { '\\overbrace', '{', '}' },
    ub = { '\\underbrace', '{', '}' },
    ol = '\\overline',
    ul = '\\underline',
    ph = '\\phantom',
    k = { '\\section', '{', '}' },
    kk = { '\\subsection', '{', '}' },
    kkk = { '\\subsubsection', '{', '}' },
    -- greek
    a = '\\alpha',
    b = '\\beta',
    d = '\\delta',
    D = '\\Delta',
    e = '\\varepsilon',
    G = '\\Gamma',
    l = '\\lambda',
    L = '\\Lambda',
    o = '\\omega',
    P = '\\Phi',
    p = '\\varphi',
    S = '\\Sigma',
    s = '\\sigma',
    T = '\\Theta',
}

local environments = {
    al = 'align*',
    ca = 'cases',
    ga = 'gather*',
    ar = 'array',
    it = 'itemize',
    ce = 'center',
    ad = 'aligned',
}

local pairs = { '()', '[]', '||' }

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

local function partial(n)
    return f(function(_, snip)
        -- partial derivative
        local a = snip.captures[n]
        local b = snip.captures[n + 1]
        -- if numerator
        if b then
            return (b:len() == 1 and '\\partial ' or '\\partial^' .. b:len())
                .. a
        else
            return a:gsub('(%d)', '^%1'):gsub('(%l)', '\\partial %1')
        end
    end)
end

local function numinf(n, space)
    return f(function(_, snip)
        -- num to num, f to infty
        local s = snip.captures[n]:gsub('^f$', '\\infty')
        if s:len() ~= 1 and not s:match('^\\') then
            s = '{' .. s .. '}'
        end
        return (space and s:match('^%a')) and ' ' .. s or s
    end)
end

local snippets = List.new({
    -- v for determinant, %d for column count
    sleadr('(v?)mat(%d) (.+)', f(mat)),
}):concat(vim.tbl_map(function(pair)
    local left = '\\left' .. pair:sub(1, #pair / 2)
    local right = '\\right' .. pair:sub(#pair / 2 + 1, #pair)
    return sw(pair, { t(left), i(1), t(right), i(0) })
end, pairs))

local autosnippets = List.new({
    sleadr('(%l)nk ', fmta('<>_{n_k}', { l(l.CAPTURE1) })),
    sleadr('sy(%d) ', fmta('\\operatorname{Syl}_<>', { l(l.CAPTURE1) })),
    sleadr('bb(%l) ', fmta('\\mathbb{<>}', { l(l.CAPTURE1:upper()) })),
    slead('pro ', t({ '\\textit{Proof.}', '' })),
    sleadr(
        'bb(%l)([+-]) ',
        fmta('\\mathbb{<>}^<>', {
            l(l.CAPTURE1:upper()),
            l(l.CAPTURE2),
        })
    ),
    sleadr(
        'bb(%l)(%S) ',
        fmta('\\mathbb{<>}_<>', {
            l(l.CAPTURE1:upper()),
            l(l.CAPTURE2),
        })
    ),
    sleadr('cal(%l) ', fmta('\\mathcal{<>}', { l(l.CAPTURE1:upper()) })),
    sleadr(
        'cal(%l)(%l) ',
        fmta(
            '\\mathcal{<>}(<>)',
            { l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper()) }
        )
    ),
    sleadr(
        'lim(%l)(%S) ',
        fmta('\\lim_{<x>\\to<to>}', {
            x = l(l.CAPTURE1),
            to = numinf(2, true),
        })
    ),
    -- derivative in Leibniz's notation
    sleadr(
        'der(%l)(%l)',
        fmta('\\frac{d<>}{d<>}', {
            l(l.CAPTURE1),
            l(l.CAPTURE2),
        })
    ),
    -- partial derivative
    sleadr(
        '(d?)par([^t])(%w+) ',
        fmta('\\<>frac{<>}{<>}', {
            l(l.CAPTURE1),
            partial(2),
            partial(3),
        })
    ),
    sleadr(
        'sum(%l)(%S) ',
        fmta('\\sum_{<x>=1}^<to>', {
            x = l(l.CAPTURE1),
            to = numinf(2),
        })
    ),
    sleadr(
        'sum(%l)(%S)(%w+) ',
        fmta('\\sum_{<i>=<a>}^<b>', {
            i = l(l.CAPTURE1),
            a = l(l.CAPTURE2),
            b = numinf(3),
        })
    ),
    sleadr('int(%l) ', fmt('\\int{}\\,d{x}', { x = l(l.CAPTURE1), i(0) })),
    sleadr(
        'int (%S+) (%S+) (%S+) ',
        fmt('\\int_{a}^{b}{}\\,d{var}', {
            a = numinf(1),
            b = numinf(2),
            i(0),
            var = l(l.CAPTURE3),
        })
    ),
    sleadr(
        'beg(%l+) ',
        fmta('\\begin{<env>}\n<>\n\\end{<env>}', { env = l(l.CAPTURE1), i(0) })
    ),
    sleadr(
        'beg ',
        fmta('\\begin{<env>}\n<>\n\\end{<env>}', { env = i(1), i(0) })
    ),
}):concat(
    ifmtas({
        ['u '] = '$<>$',
        ['uu '] = '$$\n<>\n$$',
        ['ud '] = '$\\displaystyle<>$',
    }),
    kv_slead(function(env)
        return fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
            env = t(env),
            d(1, function(_, parent)
                local raw = vim.tbl_map(function(line)
                    return '  ' .. line
                end, parent.env.SELECT_RAW)
                return sn(nil, #raw > 0 and t(raw) or { t('\t'), i(1) })
            end),
        })
    end, environments),
    kv_slead(function(sub)
        return type(sub) == 'string' and t(sub)
            or {
                t(sub[1]),
                d(1, function(_, parent)
                    return sn(nil, {
                        t(sub[2]),
                        (#parent.env.SELECT_RAW > 0)
                                and t(parent.env.SELECT_RAW)
                            or i(1),
                        t(sub[3]),
                    })
                end),
            }
    end, commands)
)

return snippets, autosnippets
