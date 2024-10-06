local List = require('plenary.collections.py_list')
require('util.luasnip')
local symbols = require('util.agda').symbols

return kv_map(function(trig, name)
    return s('\\' .. trig, t(name))
end, symbols),
    kv_map(function(trig, name)
        return s(
            { trig = '\\' .. trig .. ' ', wordTrig = false },
            t(name .. ' ')
        )
    end, symbols)
