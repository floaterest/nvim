local luasnip = require('luasnip')
local func = require('plenary.functional')

s = luasnip.s
t = luasnip.t
i = luasnip.i
f = require('luasnip.nodes.functionNode').F
d = require('luasnip.nodes.dynamicNode').D
l = require('luasnip.extras').lambda
rep = require('luasnip.extras').rep
fmt = require('luasnip.extras.fmt').fmt
fmta = require('luasnip.extras.fmt').fmta
trig = function(tr)
    return { trig = tr, wordTrig = false }
end
rtrig = function(tr)
    return { trig = tr, wordTrig = false, regTrig = true }
end

function pack(snippets)
    local t = {}
    for _, v in ipairs(snippets) do
        if type(v) == 'table' then
            for _, w in ipairs(v) do
                table.insert(t, w)
            end
        else
            table.insert(t, v)
        end
    end
    return t
end

function map(tt, f)
    local t = {}
    for k, v in pairs(tt) do
        table.insert(t, f(k, v))
    end
    return t
end

function starmap(fun, t)
    return func.kv_map(function(kv) return fun(unpack(kv)) end, t)
end

ifmtas = func.partial(starmap, function(trigger, template)
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
