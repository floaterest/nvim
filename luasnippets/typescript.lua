local snips = {
    s('log', fmta('console.log(<>)', { i(0) })),
    s('dbg', fmta('console.debug(<>)', { i(0) }))
}
return snips
