local builtin = require('telescope.builtin')

require('telescope').setup({
})

return function(register, keymaps) register(keymaps, builtin) end
