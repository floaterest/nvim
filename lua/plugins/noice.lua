return {
	routes = {
		-- {
		-- 	filter = {
		-- 		event = "msg_show",
		-- 		find = "Offline", -- copilot
		-- 	},
		-- 	opts = { skip = true },
		-- },
		-- {
		-- 	filter = {
		-- 		event = "notify",
		-- 		any = {
		-- 			{ find = "was properly" },
		-- 			{ find = " -> " },
		-- 			{ find = "Already" },
		-- 		},
		-- 	},
		-- 	view = "mini",
		-- },
	},
	lsp = {
		progress = { enabled = false },
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	messages = {
		view_error = "mini",
		view_warn = "mini",
	},
	views = {
		notify = {
			timeout = 500,
			render = "minimal",
		},
	},
}
