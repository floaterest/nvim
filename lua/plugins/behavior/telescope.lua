local builtin = require('telescope.builtin')

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            '%.git[\\/]', 'node_modules[/\\]', 'target[/\\]'
        },
        multi_icon = '', color_devicons = true,
    }
})

return function(register, keymaps) register(keymaps, builtin) end
