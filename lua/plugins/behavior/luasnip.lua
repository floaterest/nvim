local luasnip = require('luasnip')

luasnip.config.set_config({
    history = false, enable_autosnippets = true,
    update_events = 'InsertLeave', store_selection_keys = '<Tab>',
    snip_env = {
        s = luasnip.s, sn = luasnip.sn, t = luasnip.t, i = luasnip.i,
        f = require('luasnip.nodes.functionNode').F,
        d = require('luasnip.nodes.dynamicNode').D,
        l = require('luasnip.extras').lambda,
        rep = require('luasnip.extras').rep,
        fmt = require('luasnip.extras.fmt').fmt,
        fmta = require('luasnip.extras.fmt').fmta,
        parse = require('luasnip.util.parser').parse_snippet,
        pack = function(snippets)
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
        end,
        map = function(tt, f)
            local t = {}
            for k, v in pairs(tt) do
                table.insert(t, f(k, v))
            end
            return t
        end,
        trig = function(tr)
            return { trig = tr, wordTrig = false }
        end,
        rtrig = function(tr)
            return { trig = tr, wordTrig = false, regTrig = true }
        end
    }
})

require('luasnip.loaders.from_lua').lazy_load()
local path = { paths = { vim.fn.getcwd() .. '/luasnippets/' }}
require('luasnip.loaders.from_lua').load(path)

vim.cmd([[
    au BufWritePost */luasnippets/*.lua :lua require('luasnip.loaders.from_lua').lazy_load()
    command! LuaSnipEdit :lua require('luasnip.loaders.from_lua').edit_snippet_files()
]])
