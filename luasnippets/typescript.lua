require('util.luasnip')

local snips = {
    { 'log', 'console.log(<>)' },
    { 'dbg', 'console.debug(<>)' },
}

return ifmtas(snips)
