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

	local sources = {
		-- ca.eslint_d.with(eslint),
		-- fo.eslint_d.with(eslint),
		-- fo.jq,
		-- fo.rustfmt,
		-- fo.blue,
		fo.raco_fmt,
		fo.stylua,
		-- fo.raco_fmt.with({
		--     extra_args = {'--width', '60'}
		-- }),
		-- di.flake8,
		-- di.pylint.with({
		--     filter = function(diagnostic)
		--         return diagnostic.code ~= "unused-argument"
		--     end,
		-- }),
		fo.fourmolu,
		fo.clang_format,
	}

	null.setup({
		sources = sources,
	})
end