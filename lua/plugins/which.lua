local which = require("which-key")
local func = require("plenary.functional")

local other = "<leader>p"

local function copy()
	vim.fn.setreg("+", vim.fn.join(vim.fn.getbufline("%", 1, "$"), "\n"), "l")
	print("Copied buffer to clipboard")
end

local function wincmd(key)
	return function()
		vim.cmd.wincmd(key)
	end
end

local function bd()
	vim.cmd.bn()
	vim.cmd.bd("#")
end

local default = {
	{ "<c-c>", copy, desc = "Copy buffer" },
	{ "<c-s>", vim.cmd.w, desc = "Save buffer" },
	{ "<c-n>", "<cmd>Noice dismiss<cr>", desc = "Dismiss Noice" },
	{ "H", vim.cmd.bp, desc = "Go to previous" },
	{ "L", vim.cmd.bn, desc = "Go to next" },
	{ "Y", "y$", desc = "Yank until EOL" },

	{ other, group = "other" },

	{ "<leader>P", '"+P', desc = "System paste before", mode = { "n", "x" } },
	{ "<leader>d", vim.cmd.bd, desc = "Delete buffer" },
	{ "<leader>p", '"+p', desc = "System paste", mode = { "n", "x" } },
	{ "<leader>q", vim.cmd.q, desc = "Quit" },
	{ "<leader>y", '"+y', desc = "System yank", mode = "x" },
	{ "<leader>D", bd, desc = "Delete buffer #" },

	{ "<leader>t", group = "Tab" },
	{ "<leader>tc", vim.cmd.tabc, desc = "Close tab" },
	{ "<leader>to", vim.cmd.tabo, desc = "Close all other tabs" },
	{ "<leader>tt", ":tab sp<cr>", desc = "Open current buffer in new tab" },

	{ "<leader>w", group = "window" },
	{ "<leader>w<", wincmd("<"), desc = "Decrease Width" },
	{ "<leader>w=", wincmd("="), desc = "Equally high and wide" },
	{ "<leader>w>", wincmd(">"), desc = "Increase Width" },
	{ "<leader>wh", wincmd("h"), desc = "Go to the left window" },
	{ "<leader>wj", wincmd("j"), desc = "Go to the down window" },
	{ "<leader>wk", wincmd("k"), desc = "Go to the up window" },
	{ "<leader>wl", wincmd("l"), desc = "Go to the right window" },
	{ "<leader>ws", wincmd("s"), desc = "Split window horizontally" },
	{ "<leader>wv", wincmd("v"), desc = "Split window vertically" },
	{ "<leader>wx", wincmd("x"), desc = "Swap current with next" },
}

local function format()
	vim.lsp.buf.format({ async = true })
end

-- https://neovim.io/doc/user/lsp.html#lsp-method
local server = {
	{ "<leader>=", format, desc = "Format file" },
	{ "<leader>a", vim.lsp.buf.code_action, desc = "List code actions" },
	{ "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },

	{ "<leader>g", group = "goto" },
	{ "<leader>gD", vim.lsp.buf.declaration, desc = "Declaration" },
	{ "<leader>gd", vim.lsp.buf.definition, desc = "Definition" },
	{ "<leader>gi", vim.lsp.buf.implementation, desc = "Implementation" },
	{ "<leader>gr", vim.lsp.buf.references, desc = "References" },
	{ "K", vim.lsp.buf.hover, desc = "Hover" },
	{ "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
	{ "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
}

--[[
    TODO dap dapui

    spc d d Debug/Continue
    spc d b (Toggle breakpoint)

    s scopes
    b breakpoints
    t stacks (threads)
    w watches
    r repl
    c console

    spc d t * (toggle * window)
    spc d p * j (put * down (left bottom))
    spc d p * l (put repl left (bottom left))
    spc d g b (set focus on breakpoints window) (idk how)
    spc d u (toggle ui)
]]

which.setup({
	replace = { key = { { "<Space>", "SPC" } } },
	icons = { breadcrumb = "›", separator = "→" },
	preset = "classic",
	spec = default,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		which.add(vim.tbl_map(function(t)
			return vim.tbl_extend("force", t, { buffer = ev.buf })
		end, server))
	end,
})

local status, api = pcall(require, "Comment.api")
if status then
	which.add({
		{ "<leader>c", api.toggle.linewise.current, desc = "Comment line" },
		{ "<leader>C", api.toggle.blockwise.current, desc = "Comment block" },
	})
end

local status, builtin = pcall(require, "telescope.builtin")
if status then
	which.add({
		{ "<leader>b", builtin.buffers, desc = "Find buffer" },
		{ "<leader>f", builtin.find_files, desc = "Find file" },
		{ other .. "g", builtin.live_grep, desc = "Live grep" },
	})
end

local status, api = pcall(require, "nvim-tree.api")
if status then
	which.add({ other .. "t", api.tree.toggle, desc = "Toggle tree" })
end

local status, ses = pcall(require, "session_manager")
if status then
	which.add({
		{ "<leader>o", ses.load_current_dir_session, desc = "Open last session here" },
		{ "<leader>s", ses.load_session, desc = "Select sessions" },
	})
end
