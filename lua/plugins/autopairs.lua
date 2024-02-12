local Rule = require('nvim-autopairs.rule')
local autopairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

autopairs.setup({})

autopairs.add_rules({
    Rule("$", "$", {"tex", "latex"})
        :with_move(cond.done())
        :with_pair(cond.not_before_text("\\"))
        :with_cr(cond.none()),
  }
)
