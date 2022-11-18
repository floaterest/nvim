local rule = require('nvim-autopairs.rule')
local pairs = require('nvim-autopairs')

pairs.setup({
	map_cr = true
})

pairs.add_rule(rule('*', '*', 'markdown'))
