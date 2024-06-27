local function notcomment()
	local context = require("cmp.config.context")
	-- don't cmp in command mode
	if vim.api.nvim_get_mode().mode == "c" then
		return false
	end
	local treesitter = context.in_treesitter_capture("comment")
	local syntax = context.in_syntax_group("Comment")
	return not treesitter and not syntax
end

local function has_words_before()
	local num, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(0, num - 1, num, true)[1]
	return col ~= 0 and line:sub(col, col):match("%s") == nil
end

local function tab(cmp, luasnip, fallback)
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif cmp.visible() and cmp.get_selected_entry() then
		cmp.confirm()
	elseif cmp.visible() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

local function stab(cmp, luasnip, fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

return function()
	local cmp = require("cmp")
	local s, luasnip = pcall(require, "luasnip")
	if not s then
		return
	end
	local func = require("plenary.functional")

	local keymaps = {
		-- tab to luasnip expand or cmp complete
		["<tab>"] = cmp.mapping(func.partial(tab, cmp, luasnip), { "i", "s" }),
		["<s-tab>"] = cmp.mapping(func.partial(stab, cmp, luasnip), { "i", "s" }),
		["<c-b>"] = cmp.mapping.scroll_docs(-4),
		["<c-f>"] = cmp.mapping.scroll_docs(4),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-e>"] = cmp.mapping.abort(),
		-- ["<CR>"] = cmp
	}

	cmp.setup({
		enabled = notcomment,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert(keymaps),
		sources = cmp.config.sources({
			{ name = "copilot" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			-- { name = "buffer" },
			{ name = "nvim_lsp_signature_help" },
		}),
	})
end
