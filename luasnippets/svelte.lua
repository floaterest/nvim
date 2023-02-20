require('util.luasnip')

local snips = {
    ts = '<script lang="ts">\n\t{}\n</script>',
    sass = '<style lang="sass">\n\t{}\n</style>',
}

return ifmts(snips)
