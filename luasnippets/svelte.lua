require('util.luasnip')
List = require('plenary/collections/py_list')

local snips = {
    ts = '<script lang="ts">\n\t{}\n</script>',
    sass = '<style lang="sass">\n\t{}\n</style>',
}

local svelte = {
    each = '{#each <> as <>}\n\t<>\n{/each}',
    ['if'] = '{#if <>}\n\t<>\n{/if}',
    ['else'] = '{:else}\n',
}

return List:concat(ifmts(snips), ifmtas(svelte))
