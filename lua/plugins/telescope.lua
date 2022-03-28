require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '%.git[\\/]', 
            'node_modules[/\\]',
            '%.idea[/\\]',
        },
        multi_icon = '',
        color_devicons = true,
    }
})
