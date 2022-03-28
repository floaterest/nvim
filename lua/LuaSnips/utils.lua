function pack(snippets)
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
end


function map(tt, f)
    t = {}
    for k, v in pairs(tt) do
        table.insert(t, f(k, v))
    end
    return t
end

function trig(tr)
    return { trig = tr, wordTrig = false}
end

function rtrig(tr)
    return { trig = tr, wordTrig = false, regTrig = true}
end

return {
    pack = pack,
    map = map,
    trig = trig,
    rtrig = rtrig,
}
