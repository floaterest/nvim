vim.cmd('ru! innit.vim')

require('colo')
require('autocmd')
require('options')
require('plugins')

if vim.g.neovide then require('neovide') end
