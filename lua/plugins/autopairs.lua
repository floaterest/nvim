local rule = require('nvim-autopairs.rule')
local pairs = require('nvim-autopairs')

pairs.setup({})
pairs.add_rule(rule('*', '*', 'markdown'))
