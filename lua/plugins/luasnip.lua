local luasnip = require('luasnip')

luasnip.config.set_config({
    history = false,
    enable_autosnippets = true,
    region_check_events = 'InsertEnter',
    store_selection_keys = '<tab>',
})

luasnip.filetype_extend('svelte', { 'typescript' })
luasnip.filetype_extend('markdown', { 'tex' })

require('luasnip.loaders.from_lua').lazy_load()

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*/luasnippets/*.lua',
    callback = function() require('luasnip.loaders.from_lua').lazy_load() end
})

vim.api.nvim_create_user_command('LuaSnipEdit',
    function() require('luasnip.loaders.from_lua').edit_snippet_files() end,
    {}
)
