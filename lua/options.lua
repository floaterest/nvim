vim.o.ai = true -- autoindent
vim.o.ar = true -- reload file changes (autoread)
vim.o.bs = "indent,eol,start" -- allow backspace
vim.o.cole = 2 -- conceal level
vim.o.cot = "menuone,noinsert,noselect" -- complete option
vim.o.cul = true -- highlight current line
vim.o.et = true -- <tab> expands to spaces
vim.o.hid = true -- allow multiple unsaved buffers
vim.o.hls = false -- no highlight after search
vim.o.hlsearch = true -- highlight all search results
vim.o.mouse = "a" -- enable mouse
vim.o.nu = true -- current line number
vim.o.ph = 4 -- max popmenu height
vim.o.rnu = true -- relative line number
vim.o.sb = true -- split below
vim.o.scl = 'number' -- show error at line number
-- vim.o.shm = "asWF" -- shortmess
vim.o.si = true -- smart indent
vim.o.smc = 500 -- don't syntax highlight after 500 lines
vim.o.smd = false -- don't show '-- insert --'
vim.o.so = 8 -- num of lines to keep above/below cursor
vim.o.spr = true -- split right
vim.o.sts = 4 -- spaces per tab
vim.o.sw = 4 -- columns per shift
vim.o.swf = false -- no swap file
vim.o.tgc = true -- use 24-bit color
vim.o.tm = 500 -- timeout in ms (e.g. for whichkey)
vim.o.ts = 4 -- columns per tabstop
vim.o.wrap = false -- no word wrap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.filetype.add({
	extension = {
		mdx = "markdown",
		typ = 'typst',
	},
})
