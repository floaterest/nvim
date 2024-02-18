vim.bo.ts = 2
vim.bo.sts = 2
vim.bo.sw = 2
vim.opt_local.wrap = true
vim.opt_local.cc = "0"

-- surround
local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
	surrounds = {
		c = {
			add = function()
				local cmd = config.get_input("Command: ")
				return { { "\\" .. cmd .. "{" }, { "}" } }
			end,
			find = function()
				return config.get_selection({
					node = { "generic_command", "label_definition" },
				})
			end,
			change = {
				target = "^\\([^%{]*)().-()()$",
				replacement = function()
					local cmd = config.get_input("Command: ")
					return { { cmd }, {} }
				end,
			},
			delete = function()
				local sel = config.get_selections({
					char = config.command,
					pattern = "^(\\.-{)().-(})()$",
				})
				if sel then
					return sel
				end
				return config.get_selections({
					char = config.command,
					pattern = "^(\\.*)().-()()$",
				})
			end,
		},
		e = {
			add = function()
				local env = config.get_input("Environment: ")
				return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
			end,
			find = function()
				return config.get_selection({
					node = { "generic_environment", "math_environment" },
				})
			end,
			delete = function()
				local sel = config.get_selections({
					char = config.environment,
					pattern = "^(\\begin%b{}%b[])().-(\\end%b{})()$",
				})
				if sel then
					return sel
				end
				return config.get_selections({
					char = config.environment,
					pattern = "^(\\begin%b{})().-(\\end%b{})()$",
				})
			end,
			change = {
				target = "^\\begin{([^%}]*)().-\\end{([^%}]*)()}$",
				replacement = function()
					local cmd = config.get_input("Environment: ")
					return { { cmd }, { cmd } }
				end,
			},
		},
	},
})
