
local function typstyle(h, methods) return h.make_builtin({
	name = "typstyle",
	meta = {
		url = "https://github.com/Enter-tainer/typstyle",
		description = "Beautiful and reliable typst code formatter ",
	},
	method = methods.internal.FORMATTING,
	filetypes = { "typ", "typst" },
	generator_opts = {
		command = "typstyle",
		args = { },
		to_stdin = true,
	},
	factory = h.formatter_factory,
})end


return function()
	local null = require("null-ls")

	local di = null.builtins.diagnostics
	local ca = null.builtins.code_actions
	local fo = null.builtins.formatting

	local eslint = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
		},
	}
	local h = require("null-ls.helpers")
	local methods = require("null-ls.methods")

	local sources = {
		-- ca.eslint_d.with(eslint),
		-- fo.eslint_d.with(eslint),
		-- fo.jq,
		-- fo.blue,
		fo.stylua,
		-- fo.typstfmt,
		typstyle(h,methods),
		-- fo.raco_fmt.with({
		--     extra_args = {'--width', '60'}
		-- }),
		-- di.flake8,
		-- di.pylint.with({
		--     filter = function(diagnostic)
		--         return diagnostic.code ~= "unused-argument"
		--     end,
		-- }),
		-- fo.clang_format,
	}

	null.setup({ sources = sources })
end
