-- allow backspace
vim.o.bs = 'indent,eol,start'
-- timeout in ms (e.g. for whichkey)
vim.o.tm = 500
-- num of lines to keep above/below cursor
vim.o.so = 8
-- shift width
vim.o.sw = 4
-- tabstop
vim.o.ts = 4

-- rel + abs line number
vim.o.nu = true
vim.o.rnu = true
-- keep visual indent on wrap
vim.o.bri = true
-- complete option
vim.o.cot = "menuone,noinsert,noselect"
-- allow multiple unsaved buffers
vim.o.hid = true
-- no highlight after search
vim.o.hls = false
-- don't syntax highlight after 1000 lines
vim.o.smc = 1000
-- don't show '-- insert --'
vim.o.smd = false
-- no swap file
vim.o.swf = false
-- use 24-bit color
vim.o.tgc = true

-- conceal level
vim.o.cole = 2
-- no word wrap
vim.o.wrap = false
-- enable mouse
vim.o.mouse = "a"
-- highlight all search results
vim.o.hlsearch = true
