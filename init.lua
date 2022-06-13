vim.cmd('ru! innit.vim')

require('colorscheme').setup()
require('core')
require('plugins')

if vim.g.neovide then require('neovide') end
