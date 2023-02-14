local luasnip = require('luasnip')
local func = require('plenary.functional')

s = luasnip.s
sn = luasnip.snippet_node
t = luasnip.t
i = luasnip.i
f = require('luasnip.nodes.functionNode').F
d = require('luasnip.nodes.dynamicNode').D
l = require('luasnip.extras').lambda
rep = require('luasnip.extras').rep
fmt = require('luasnip.extras.fmt').fmt
fmta = require('luasnip.extras.fmt').fmta

function kv_map(fun, t)
    return func.kv_map(function(kv) return fun(unpack(kv)) end, t)
end

ifmtas = func.partial(kv_map, function(trigger, template)
    -- return snippet with each delimiter replaced by insert node
    local _, n = template:gsub('<>', '')
    local option = {}
    for index = 1, n do
        -- last index will be 0
        option[index] = i(index % n)
    end
    return s(trigger, fmta(template, option))
end)

return setfenv(2, _G)
