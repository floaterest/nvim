local luasnip = require('luasnip')
local s = luasnip.snippet
local sn = luasnip.snippet_node
local d = luasnip.dynamic_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local l = require('luasnip.extras').lambda
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta

local u = require((...):match('^%w+') .. '.utils')

local tab = '    '
local leader = '\\'
local trig = function(t) return u.trig(leader .. t .. ' ') end
local rtrig = function(t) return u.rtrig(leader .. t .. ' ') end

local function numinf(_, snip, ncap, space)
    local cap = snip.captures[ncap]:gsub('^f$', '\\infty')
    return (cap:match('^%a') and space) and (' ' .. cap) or cap
end

return {
    autosnippets = {},
    snippets = {},
}
