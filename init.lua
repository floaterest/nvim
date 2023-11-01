require('colo')
require('autocmd')
require('options')
require('plugins')

-- see log in ~/.local/state/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

-- enable filetype.lua
vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = true

if vim.g.neovide then require('neovide') end
