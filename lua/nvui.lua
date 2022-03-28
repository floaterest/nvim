vim.o.gfn = 'Iosevka Custom NF:h16,UD デジタル 教科書体 N-R:h16'

function _G.incfont(amount)
    local font = vim.api.nvim_eval('&gfn')
    local a, b = font:find(':h%d+')
    local size = font:sub(a + 2, b)

	vim.o.gfn = font:gsub(':h%d+', ':h' .. size + amount)
end

vim.cmd([[
	NvuiFrameless v:true
	NvuiAnimationsEnabled v:false
	NvuiTitlebarColors #ffffff #000000
	NvuiCursorAnimationDuration 0
	NvuiTitlebarSeparator ' - '
]])

