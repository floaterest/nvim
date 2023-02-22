require('util.luasnip')

local macros = {
    d = 'dbg!(<>)',
    f = 'format!(<>)',
    p = 'println!(<>)',
    w = 'write!(<>)',
    W = 'writeln!(<>)',
}

local autos = {
    '.unwrap()',
    '.collect()',
}

local autosnippets = vim.tbl_map(function(str)
    return s({ trig = str:sub(0, 3) .. ' ', wordTrig = false }, t(str))
end, autos)

return ifmtas(macros), autosnippets
