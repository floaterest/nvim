vim.cmd('ru! innit.vim')

require('colo')
require('autocmd')
require('options')
require('plugins')

-- vim.lsp.set_log_level("debug")


if vim.g.neovide then require('neovide') end
