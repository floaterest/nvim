local List = require('plenary.collections.py_list')
require('util.luasnip')

local commands = {
    -- logic
    L = '\\mathcal L_p',
    Ls = '\\mathcal L_p^s',
    v = '\\vdash',
    V = '\\vDash',
    B = '\\mathcal B',
    F = '\\{F,T\\}',
    oo = { '\\overline', '{\\overline ', '}' },
    En = '\\mathcal E_\\neg',
    Es = '\\mathcal E_\\square',
    W = '\\mathcal W_p',
    -- computation
    Sa = '\\Sigma^\\ast',
    Ga = '\\Gamma^\\ast',
    an = { '', '\\langle ', '\\rangle' },
    fl = { '', '\\lfloor', '\\rfloor' },
    ce = { '', '\\lceil', '\\rceil' },
    -- proof
    tf = '\\therefore',
    bc = '\\because',
    tF = '\\therefore&&',
    bC = '\\because&&',
    tff = '\\therefore\\,&',
    bcc = '\\because\\,&',
    qed = '\\quad\\square',
    f = { '\\frac', '{', '}' },
    im = '\\implies',
    i = '^{-1}',
    fo = '\\forall',
    ex = '\\exists',
    -- typography
    q = '\\quad',
    en = '\\enspace',
    st = '\\text{ st }',
    t = { '\\text', '{', '}' },
    tt = { '\\texttt', '{', '}' },
    bf = { '\\textbf', '{', '}' },
    rm = { '\\mathrm', '{', '}' },
    g = { '\\tag', '{', '}' },
    ob = { '\\overbrace', '{', '}' },
    ub = { '\\underbrace', '{', '}' },
    ol = '\\overline',
    ul = '\\underline',
    ss = { '\\subsection*', '{', '}' },
    sss = { '\\subsubsection*', '{', '}' },
    -- set
    no = '\\varnothing',
    un = '\\cup',
    Un = '\\bigcup',
    mi = '\\setminus',
    se = '\\subseteq',
    su = '\\subset',
    -- greek
    a = '\\alpha',
    b = '\\beta',
    d = '\\delta',
    D = '\\Delta',
    e = '\\varepsilon',
    G = '\\Gamma',
    l = '\\lambda',
    P = '\\Phi',
    p = '\\varphi',
    S = '\\Sigma',
    s = '\\sigma',
}

local environments = {
    al = 'aligned', ca = 'cases', ga = 'gather*', ar = 'array', it = 'itemize',
}

local leader = '\\'

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


local autosnippets = List.new({
    sleadr('bb(%l) ', fmt('\\mathbb {}', { l(l.CAPTURE1:upper()) })),
    sleadr('cal(%l) ', fmt('\\mathcal {}', { l(l.CAPTURE1:upper()) })),
    sleadr('cal(%l)(.) ', fmta('\\mathcal <>(<>)', {
        l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper())
    })),
    sleadr('cal(%l)(.)(.)', fmta('\\mathcal <>(<>,<>)', {
        l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper()), l(l.CAPTURE3:upper())
    })),
    sleadr('beg(%l+) ', fmta('\\begin{<env>}\n<>\n\\end{<env>}', { env = l(l.CAPTURE1), i(0) })),
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
            end)
        })
    end, environments),
    kv_slead(function(sub)
        return type(sub) == 'string' and t(sub) or {
            t(sub[1]),
            d(1, function(_, parent)
                return sn(nil, {
                    t(sub[2]),
                    (#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
                    t(sub[3])
                })
            end)
        }
    end, commands)
)

return {}, autosnippets
