-- basically all the languages I know/use
-- run :TSInstallInfo to see list

-- markdown_inline?
-- not found: sass mdx
local languages = {
	"astro",
	"bash",
	"c",
	"cpp",
	"css",
	"haskell",
	"html",
	"javascript",
	"jsonc",
	"lua",
	"markdown",
"markdown_inline",
	"python",
	"regex",
	"rust",
	"svelte",
	"toml",
	"typescript",
	"vim",
	"yaml",
}

require("nvim-treesitter.configs").setup({
	ensure_installed = languages,
	highlight = { enable = true },
	playground = { enable = true },
})

vim.treesitter.language.register("markdown", "mdx")

-- code folding
vim.o.fdm = "expr"
vim.o.fde = "nvim_treesitter#foldexpr()"
vim.o.fdl = 99
