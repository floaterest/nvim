return function()
	local Rule = require("nvim-autopairs.rule")
	local autopairs = require("nvim-autopairs")
	local cond = require("nvim-autopairs.conds")
	local ts_conds = require("nvim-autopairs.ts-conds")
	autopairs.setup({})
	autopairs.add_rules({
		Rule("$", "$", { "tex", "latex", "typst" })
			:with_move(cond.done())
			:with_pair(cond.not_before_text("\\"))
			:with_cr(cond.done()),
		Rule("```", "```", { "typst" })
			:with_move(cond.done())
			:with_pair(cond.not_before_text("\\"))
			:with_cr(cond.none()),
	})
end
