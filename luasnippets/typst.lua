local List = require('plenary.collections.py_list')
require('util.luasnip')

local greek = {
    a = 'α',
    b = 'β',
    d = 'δ',
    D = 'Δ',
    h = 'η',
    g = 'γ',
    G = 'Γ',
    k = 'κ',
    l = 'λ',
    L = 'Λ',
    m = 'μ',
    n = 'ν',
    o = 'ω',
    O = 'Ω',
    -- Phi = 'Φ',
    p = 'π',
    P = 'Π',
    -- x = 'ψ',
    -- X = 'Ψ',
    r = 'ρ',
    s = 'σ',
    S = 'Σ',
    t = 'τ',
    th = 'θ',
    TH = 'Θ',
    e = 'ε', -- εϵ
    f = 'φ',
    F = 'Φ',
    z = 'ζ',

    c = 'ξ',
    C = 'Ξ',
    le = '⩽',
    i = '^(-1)',
    no = 'nothing',
    iff = '<==>',
}

local subs = {
    -- algebra
    -- set
    -- logic
    fo = '∀',
    ex = '∃',
    pm = '±',
    mp = '∓',
    dc = '⋯',
    nex = '∄',
    im = '==>',
    mi = '<==',
    sq = '□',
}

local slash = {
    n = 'ₙ',
    ['0'] = '₀',
    ['1'] = '₁',
    ['2'] = '₂',
    ['3'] = '₃',
    ['4'] = '₄',
    ['5'] = '₅',
    ['6'] = '₆',
    ['7'] = '₇',
    ['8'] = '₈',
    ['in'] = '∈',
}

local space = {
    joi = '⋈',
    int = '∫',
    dot = '·',
    lt = '<',
    gt = '>',
    sp = 'space',
    ti = '×',
    psi = 'ψ',
    phi = 'φ',
    equiv = '\u{2261}',
    nequiv = '\u{2262}',
    til = '∼',
    bc = '∵',
    bcc = '∵ &&',
    tf = '∴',
    tff = '∴ &&',
    eq = '&=',
    eqq = '&&=',
    -- logic
    vd = '⊢',
    vD = '⊨',
    nvd = '⊬',
    de = '≝',
    ne = '≠',
    iso = '≅',
    niso = '≇',
    -- set
    -- ['in'] = '∈',
    nin = '∉',
    su = '⊂',
    ['00'] = '∞',
    se = '⊆',
    nse = '⊈',
    es = '⊇',
    sect = '∩',
    un = '∪',
    uq = '⊔',
    -- le = '≤',
    -- ge = '≥',
    Un = 'union.big',
    Se = 'sect.big',
    -- typography
    qu = 'quad',
    h1 = '#h(1fr)',
    oplus = '\u{2295}',
}

local commands = {
    'definition',
    'theorem',
    'example',
}

local snip = List.new({
    s('an', fmt('⟨{}⟩', { i(0) })),
}):concat(
    kv_map(function(trig, name)
        return s(trig, t(name))
    end, greek),
    kv_map(function(trig, name)
        return s(trig, t(name))
    end, space),
    kv_map(function(trig, name)
        return s({ trig = '_' .. trig, wordTrig = false }, t('_' .. name))
    end, greek)
)

-- ε

local auto = List.new({
    -- s("$ ", fmta("$ <> ", { i(0) })),
    s('ol ', fmta('overline(<>)', { i(0) })),
    s('ul ', fmta('underline(<>)', { i(0) })),
    s({ trig = '\\i ', wordTrig = false }, t('^(-1)')),
    s({ trig = '\\o ', wordTrig = false }, t('ö')),
    s('ss ', { t('#strike['), i(0), t(']') }),
    s('u ', { t('$'), i(1), t('$'), i(0) }),
    s(
        { trig = 'c([abcdfklopqstux]) ', regTrig = true },
        fmta('cal(<>)', { l(l.CAPTURE1:upper()) })
    ),
    -- s({ trig = "c(%l)(%l) ", regTrig = true }, fmta("cal(<>)(<>)", { l(l.CAPTURE1:upper()), l(l.CAPTURE2:upper()) })),
}):concat(
    kv_map(function(trig, name)
        return s(trig .. ' ', t(name))
    end, subs),
    kv_map(function(trig, name)
        return s({trig='\\' .. trig .. ' ',wordTrig=false}, t(name))
    end, slash),
    kv_map(function(trig, name)
        return s(trig .. ' ', t(name .. ' '))
    end, space),
    vim.tbl_map(function(name)
        return s(
            '#' .. name:sub(0, 3) .. ' ',
            fmt('#{}[{}]', { t(name), i(0) })
        )
    end, commands)
)

return snip, auto
