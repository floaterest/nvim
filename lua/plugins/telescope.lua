local telescope = require("telescope")
local config = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- don't search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},
})
telescope.load_extension("file_browser")
