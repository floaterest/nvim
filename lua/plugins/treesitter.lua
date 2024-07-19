local languages = {
    'astro',
    'bash',
    'c',
    'cpp',
    'css',
    'haskell',
    'html',
    'javascript',
    'jsonc',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'typst',
    'regex',
    'rust',
    'svelte',
    'toml',
    'typescript',
    'vim',
    'yaml',
}

local select = {
    enable = true,
    lookahead = true,
    keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
    },
}

return function()
    require('nvim-treesitter.configs').setup({
        ensure_installed = languages,
        textobjects = { select = select },
        highlight = { enable = true },
        playground = { enable = true },
    })
    require('util.treesitter')()
    vim.treesitter.language.register('markdown', 'mdx')
    -- code folding
    vim.o.fdm = 'expr'
    vim.o.fde = 'nvim_treesitter#foldexpr()'
    vim.o.fdl = 99
end
