local luasnip = require('luasnip')

local dir = 'LuaSnips/'
local absdir = '$XDG_CONFIG_HOME/nvim/lua/' .. dir

local function term(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.clear_snippets()
	for _, snip in ipairs({ 'snippets', 'autosnippets'}) do
		luasnip[snip] = setmetatable({}, {
			__index = function(t, k)
				local ok, m = pcall(require, dir .. k)
				if not ok and not m:match('^module.*not found:') then
					error(m)
				end
				t[k] = ok and m[snip] or {}
				return t[k]
			end
		})	
	end
end

function _G.edit_ftype()
	local ftypes = require('luasnip.util.util').get_snippet_filetypes()
	vim.ui.select(ftypes, { prompt = 'Select which filetype to edit:'},
		function(item, i)
			if i then
				vim.cmd('edit ' .. absdir .. item .. '.lua')
			end
		end
	)
end

function _G.complete()
	if luasnip and luasnip.expand_or_jumpable() then
		return term('<Plug>luasnip-expand-or-jump')
	else
		return '    '
	end
end

luasnip.config.set_config({
	history = true,
	updateevents = 'TextChanged',
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
    store_selection_keys='<Tab>',
})

_G.clear_snippets()

vim.cmd([[
	augroup snippets_clear
	au!
	au BufWritePost ]] .. absdir .. [[*.lua lua _G.clear_snippets()
	augroup END
]])

map = vim.api.nvim_set_keymap

vim.cmd [[command! LuaSnipEdit :lua _G.edit_ftype()]]

-- more mappings at mappings.lua
map('i','<tab>','v:lua.complete()', { expr = true })
map('s','<tab>','v:lua.complete()', { expr = true })
