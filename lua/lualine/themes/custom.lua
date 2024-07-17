local colors = require("color.colors")

return {
	normal = {
		a = { fg = colors.black, bg = colors.teal, gui = "bold" },
		b = { fg = colors.lightest, bg = colors.darker },
		c = { fg = colors.lighter, bg = colors.black },
	},
	terminal = {
		a = { fg = colors.black, bg = colors.sky, gui = "bold" },
	},
	insert = {
		a = { fg = colors.black, bg = colors.sky, gui = "bold" },
	},
	visual = {
		a = { fg = colors.black, bg = colors.orange, gui = "bold" },
	},
	replace = {
		a = { fg = colors.black, bg = colors.purple, gui = "bold" },
	},
	command = {
		a = { fg = colors.black, bg = colors.pink, gui = "bold" },
	},
	inactive = {
		a = { fg = colors.lightest, bg = colors.gray, gui = "bold" },
		b = { fg = colors.lighter, bg = colors.darker },
		c = { fg = colors.light, bg = colors.darkest },
	},
}
