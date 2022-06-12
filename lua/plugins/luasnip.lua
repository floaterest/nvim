local luasnip = require('luasnip')

local dir = 'LuaSnips/'
local absdir = '$XDG_CONFIG_HOME/nvim/lua/' .. dir

local function term(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.complete()
    if luasnip and luasnip.expand_or_jumpable() then
        return term('<Plug>luasnip-expand-or-jump')
    else
        return '    '
    end
end

luasnip.config.set_config({
    history = true,
    update_events = "InsertLeave",
    enable_autosnippets = true,
    ext_base_prio = 300,
    ext_prio_increase = 1,
    store_selection_keys = '<Tab>',
    snip_env = {
        s = require("luasnip.nodes.snippet").S,
        sn = require("luasnip.nodes.snippet").SN,
        t = require("luasnip.nodes.textNode").T,
        f = require("luasnip.nodes.functionNode").F,
        i = require("luasnip.nodes.insertNode").I,
        d = require("luasnip.nodes.dynamicNode").D,
        l = require("luasnip.extras").lambda,
        rep = require("luasnip.extras").rep,
        fmt = require("luasnip.extras.fmt").fmt,
        fmta = require("luasnip.extras.fmt").fmta,
        parse = require("luasnip.util.parser").parse_snippet,
        pack = function(snippets)
            local t = {}
            for _, v in ipairs(snippets) do
                if(type(v) == 'table') then
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
            t = {}
            for k, v in pairs(tt) do
                table.insert(t, f(k, v))
            end
            return t
        end,
        trig = function(tr)
            return { trig = tr, wordTrig = false}
        end,
        rtrig = function(tr)
            return { trig = tr, wordTrig = false, regTrig = true}
        end
    }
})

vim.cmd([[
    augroup snippets_clear
    au!
    au BufWritePost ]] .. absdir .. [[*.lua :execute 'lua require("luasnip").snippets[string.match("'.expand("<afile>").'", "/([^/]*)%.lua$")] = nil
    augroup END
]])

map = vim.api.nvim_set_keymap
require("luasnip.loaders.from_lua").lazy_load()
vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

-- more mappings at mappings.lua
vim.cmd([[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ]])
-- map('i','<tab>','v:lua.complete()', { expr = true })
-- map('s','<tab>','v:lua.complete()', { expr = true })
