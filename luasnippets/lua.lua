local i0 = { i(0) }

return {
    s('f', fmta('function <>\nend', i0)),
    s('lf', fmta('local function <>\nend', i0)),
}, {
    s('if ', fmta('if <> then\n\t<>\nend', { i(1), i(0) }))
}
