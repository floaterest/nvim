require('util.luasnip')

local autos = {
    ['fu '] = 'function <>\n\t<>\nend',
    ['lf '] = 'local function <>\n\t<>\nend',
    ['if '] = 'if <> then\n\t<>\nend',
    ['for '] = 'for <> in pairs(<>) do\n\t<>\nend',
}

return {}, ifmtas(autos)
