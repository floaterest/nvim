local List = require('plenary.collections.py_list')
require('util.luasnip')

local commands = {
    an = { '', '\\langle ', '\\rangle' },
    s = '\\sigma',
    ss = { '\\subsection*', '{', '}' },
    sss = { '\\subsubsection*', '{', '}' },
    no = '\\varnothing',
    a = '^\\ast',

    p = '\\varphi',
    im = '\\implies',
    bf = { '\\textbf', '{', '}' },
    se = '\\subseteq',
    a = '^\\ast',
    su = '\\subset',
    d = '\\delta',
    l = '\\lambda',
    qed = '\\enspace\\square',
    e = '\\varepsilon',
    S = '\\Sigma', G = '\\Gamma', D = '\\Delta', P = '\\Phi',
    q = '\\quad', en = '\\enspace',
    tf = '\\therefore', bc = '\\because',
    fo = '\\forall', ex = '\\exists',
    tt = { '\\texttt', '{', '}' },
    t = { '\\text', '{', '}' },
}


local leader = '\\'
local function sw(trig, ...)
    return s({ trig = trig, wordTrig = false }, ...)
end
local function swr(trig, ...)
    return s({ trig = trig, wordTrig = false, regTrig = true }, ...)
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

local environments = {
    al = 'aligned', ca = 'cases', ga = 'gather*', ar = 'array', it = 'itemize',
}


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
    kv_slead(function(env) return fmta('\\begin{<env>}\n<>\n\\end{<env>}', {
        env = t(env), d(1, function(_, parent)
            local raw = vim.tbl_map(function(_, line)
                return tostring(line:gsub('^%$+', ''))
            end, parent.env.SELECT_RAW)
            return sn(nil, #raw > 0 and t(raw) or { t('\t'), i(1) })
        end)
    }) end, environments),
    kv_slead(function(sub) return type(sub) == 'string' and t(sub) or {
        t(sub[1]),
        d(1, function(_, parent) return sn(nil, {
            t(sub[2]),
            (#parent.env.SELECT_RAW > 0) and t(parent.env.SELECT_RAW) or i(1),
            t(sub[3])
        }) end)
    } end, commands)
)

return {}, autosnippets

