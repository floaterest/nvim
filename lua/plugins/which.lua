local function copy()
	vim.fn.setreg("+", vim.fn.join(vim.fn.getbufline("%", 1, "$"), "\n"), "l")
	print("Copied buffer to clipboard")
end

local vanilla = {
	L = { vim.cmd.bn, "Go to next" },
	H = { vim.cmd.bp, "Go to previous" },
	Y = { "y$", "Yank until EOL" },
	["<c-s>"] = { vim.cmd.w, "Save buffer" },
	["<c-c>"] = { copy, "Copy buffer" },
}

local function wincmd(key)
	return function()
		vim.cmd.wincmd(key)
	end
end

local leader = {
	b = {
		name = "+buffer",
		n = { vim.cmd.bn, "Next" },
		p = { vim.cmd.bp, "Previous" },
		d = { vim.cmd.bd, "Delete" },
	},
	f = {
		name = "+file",
		s = { vim.cmd.w, "Save file" },
		S = { vim.cmd.wa, "Save all files" },
	},
	q = { vim.cmd.q, "Quit" },
	w = {
		name = "+window",
		h = { wincmd("h"), "Go to left" },
		l = { wincmd("l"), "Go to right" },
		v = { wincmd("v"), "Split vertically" },
		j = { wincmd("j"), "Go to down" },
		k = { wincmd("k"), "Go to up" },
		s = { wincmd("s"), "Split horizontally" },
		x = { wincmd("x"), "Swap" },
		q = { wincmd("q"), "Quit" },
		[">"] = { wincmd(">"), "Increase Width" },
		["<"] = { wincmd("<"), "Decrease Width" },
		["="] = { wincmd("="), "Make equal size" },
	},
}

local function telescope(builtin)
	local function find_files()
		return builtin.find_files({ hidden = true })
	end
	return {
		f = { find_files, "Find file" },
		b = { builtin.buffers, "Find buffer" },
		g = { builtin.live_grep, "Live grep" },
	}, { prefix = "<leader>f" }
end

local function format()
	vim.lsp.buf.format({ async = true })
end
-- https://neovim.io/doc/user/lsp.html#lsp-method
local server = {
	a = { name = "+action", a = { vim.lsp.buf.code_action, "List code actions" } },
	r = { name = "+rename", r = { vim.lsp.buf.rename, "Rename symbol" } },
	["="] = { name = "+format", ["="] = { format, "Format file" } },
	g = {
		name = "+goto",
		d = { vim.lsp.buf.definition, "Definition" },
		D = { vim.lsp.buf.declaration, "Declaration" },
		i = { vim.lsp.buf.implementation, "Implementation" },
		r = { vim.lsp.buf.references, "References" },
	},
}

-- LSP
local function callback(which, ev)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	which.register({
		["<leader>"] = server,
		K = { vim.lsp.buf.hover, "Hover" },
		["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
		["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
	}, { buffer = ev.buf })
end

local function tree(api)
	return { t = { api.tree.toggle, "Toggle tree" } }, { prefix = "<leader>f" }
end

local function session(ses)
	return {
		name = "+session",
		s = { ses.load_session, "Select sessions" },
		o = { ses.load_last_session, "Open last session" },
		d = { ses.delete_session, "Delete sessions" },
		O = { ses.load_last_session, "Open last session here" },
	}, { prefix = "<leader>s" }
end

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

return function()
	local which = require("which-key")
	local func = require("plenary.functional")

	which.setup({
		key_labels = { ["<space>"] = "spc" },
		icons = { breadcrumb = "›", separator = "→" },
	})

	which.register(vanilla)
	which.register(leader, { prefix = "<leader>" })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = func.partial(callback, which),
	})

	local status, b = pcall(require, "telescope.builtin")
	if status then
		which.register(telescope(b))
	end

	local status, api = pcall(require, "nvim-tree.api")
	if status then
		which.register(tree(api))
	end

	local status, ses = pcall(require, "session_manager")
	if status then
		which.register(session(ses))
	end
end
