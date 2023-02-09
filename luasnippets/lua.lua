require('util.luasnip')

local snips = {
    { 'fu', 'function <>\nend' },
    { 'lf', 'local function <>\nend' },
    { 'if', 'if <> then\n\t<>\nend' },
    { 'for', 'for <> in pairs(<>) do\n\t<>\nend' },
}

return ifmtas(snips)
