local modes = {
	-- NORMAL = "No",
	-- INSERT = "In",
	-- SELECT = "Se",
	-- VISUAL = "Vi",
	-- ["V-LINE"] = "VL",
	-- ["V-BLOCK"] = "VB",
	-- VREPLACE = "VR",
	-- COMMAND = "Co",
	-- TERMINAL = "Te",
	-- ["O-PENDING"] = "OP",
	-- REPLACE = "Re",

	NORMAL = "N",
	INSERT = "I",
	SELECT = "S",
	VISUAL = "V",
	["V-LINE"] = "𝕍",
	["V-BLOCK"] = "𝑉",
	VREPLACE = "𝒱",
	COMMAND = "C",
	TERMINAL = "T",
	["O-PENDING"] = "O",
	REPLACE = "R",
	-- insert-normal insert-visual, insert-select
}

local mode = {
	"mode",
	fmt = function(s)
		return modes[s] or s
	end,
}
local filename = {
	"filename",
	-- relative path
	path = 1,
	symbols = { modified = " [+]", readonly = " [r]", unnamed = "[untitled]" },
}

local function location()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	-- return string.format('%3d:%-2d', line, col)
	return line .. ":" .. col
end

local status, noice = pcall(require, "noice")
local x = status and {
	noice.api.statusline.mode.get,
	cond = noice.api.statusline.mode.has,
} or {}

require("lualine").setup({
	options = { theme = "auto" },
	sections = {
		lualine_a = { mode },
		lualine_b = { "branch" },
		lualine_c = { filename, "diagnostics" },
		-- lualine_x = { x, { "copilot", symbols = { show_colors = true } } },
		lualine_x = { x },
		lualine_y = { "filetype" },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename, "diagnostics" },
		lualine_x = { "filesize" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {
		"nvim-tree", --'nvim-dap-ui'
	},
})
