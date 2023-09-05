-- basically all the languages I know/use
-- run :TSInstallInfo to see list

-- markdown_inline?
-- not found: sass mdx
local languages = {
    'astro', 'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'jsonc', 'lua',
    'markdown', 'python', 'regex', 'rust', 'svelte', 'toml', 'typescript',
    'vim', 'yaml', 'haskell'
}

require('nvim-treesitter.configs').setup({
    ensure_installed = languages,
    highlight = { enable = true },
    indent = { enable = true },
    playground = { enable = true },
})

-- code folding
vim.o.fdm = 'expr'
vim.o.fde = 'nvim_treesitter#foldexpr()'
vim.o.fdl = 99
