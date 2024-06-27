local header = {
	type = "text",
	val = {},
	opts = {
		position = "center",
		hl = "Type",
	},
}

return function()
	local scan = require("plenary.scandir").scan_dir
	local arts = scan(vim.fn.stdpath("config") .. "/alpha/")
	local i = os.time() % #arts + 1 -- RNG (?)

	local context_manager = require("plenary.context_manager")
	local with, open = context_manager.with, context_manager.open
	-- read lines
	with(open(arts[i], "r"), function(reader)
		repeat
			local line = reader:read("*l")
			table.insert(header.val, line)
		until line == nil
	end)

	local dashboard = require("alpha.themes.dashboard")
	local button = dashboard.button
	require("alpha").setup({
		layout = {
			header,
			{ type = "padding", val = 1 },
			{
				type = "group",
				val = {
					button("f", "󰈔  Find file", "<cmd>Telescope find_files<cr>"),
					button("g", "  Live grep", "<cmd>Telescope live_grep<cr>"),
					button("t", "  NvimTree", "<cmd>NvimTreeToggle<cr>"),
					-- button("s", "󱈄  Select sessions", "<cmd>SessionManager load_session<cr>"),
					button("o", "  Open last session", "<cmd>SessionManager load_current_dir_session<cr>"),
					button("q", "󰗼  Quit", "<cmd>qa<cr>"),
				},
				opts = { spacing = 1 },
			},
		},
	})
end
