require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
		disable = { 'tex', 'org' },
        additional_vim_regex_highlighting = { 'org' },
    }
})

-- code folding
vim.o.fdm = 'expr'
vim.o.fde = 'nvim_treesitter#foldexpr()'
vim.o.fdl = 99
