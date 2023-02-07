local luasnip = require('luasnip')
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

local t = {
    s = luasnip.s, t = luasnip.t, i = luasnip.i,
    f = require('luasnip.nodes.functionNode').F,
    d = require('luasnip.nodes.dynamicNode').D,
    l = require('luasnip.extras').lambda,
    rep = require('luasnip.extras').rep,
    fmt = require('luasnip.extras.fmt').fmt,
    fmta = require('luasnip.extras.fmt').fmta,
    pack = pack, map = map,
    trig = function(tr)
        return { trig = tr, wordTrig = false }
    end,
    rtrig = function(tr)
        return { trig = tr, wordTrig = false, regTrig = true }
    end
}

return function()
    setfenv(2, vim.tbl_extend('force', _G, t))
end
