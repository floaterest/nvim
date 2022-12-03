vim.cmd('ru! innit.vim')

require('colo')
require('core')
require('plugins')

if vim.g.neovide then require('neovide') end
