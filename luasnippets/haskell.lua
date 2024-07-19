local List = require('plenary.collections.py_list')
require('util.luasnip')

local snip = {
    a = 'α',
    b = 'β',
    c = 'χ',
    d = 'δ',
    D = 'Δ',
    h = 'η',
    g = 'γ',
    G = 'Γ',
    k = 'κ',
    l = 'λ',
    L = 'Λ',
    m = 'μ',
    o = 'ω',
    O = 'Ω',
    p = 'π',
    P = 'Π',
    x = 'ψ',
    X = 'Ψ',
    r = 'ρ',
    s = 'σ',
    S = 'Σ',
    t = 'τ',
    th = 'θ',
    Th = 'Θ',
    e = 'ε', -- ϵ
    f = 'φ',
    z = 'ζ',
}

local auto = {
    ['\\ot '] = '<- ',
    ['\\bind '] = '=<< ',
    ['\\sqcap '] = '\u{2293} ',
    ['\\oplus '] = '\u{2295} ',
    ['\\forall '] = '∀ ',
}

function sub_map(tbl)
    return kv_map(function(trig, name)
        return s(trig, t(name))
    end, tbl)
end

return sub_map(snip), sub_map(auto)
