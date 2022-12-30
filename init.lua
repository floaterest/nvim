vim.cmd('ru! innit.vim')

require('colo')
require('options')
require('plugins')

if vim.g.neovide then require('neovide') end

