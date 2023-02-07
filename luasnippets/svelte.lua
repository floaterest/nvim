require('util.luasnip')()

local snips = {
    s('ts', fmt('<script lang="ts">\n\t{}\n</script>', { i(0) })),
    s('sass', fmt('<style lang="sass">\n\t{}\n</style>', { i(0) })),
}
return snips
