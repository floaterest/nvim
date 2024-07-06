require("util.luasnip")

local symbols = {
    ['1']='① ',
    ['2']='② ',
    ['3']='③ ',
    ['4']='④ ',
    ['5']='⑤ ',
    ['6']='⑥ ',
    ['7']='⑦ ',
    ['8']='⑧ ',
    ['9']='⑨ ',

    nei = 'neighborhood'
}
return kv_map(function(trig, name)
    return s(trig, t(name))
end, symbols), {
	s("\\l ", t("<- "))
}
