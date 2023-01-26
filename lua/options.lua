local o = vim.o

-- set visual guide (colorcolumn)
o.cc = '80'
-- allow backspace
o.bs = 'indent,eol,start'
-- timeout in ms (e.g. for whichkey)
o.tm = 500
-- num of lines to keep above/below cursor
o.so = 8
-- columns per shift
o.sw = 4
-- spaces per tab
o.sts = 4
-- columns per tabstop
o.ts = 4
-- <tab> expands to spaces
o.et = true

-- rel + abs line number
o.nu = true
o.rnu = true
-- keep visual indent on wrap
o.bri = true
-- complete option
o.cot = 'menuone,noinsert,noselect'
-- allow multiple unsaved buffers
o.hid = true
-- no highlight after search
o.hls = false
-- don't syntax highlight after 1000 lines
o.smc = 1000
-- don't show '-- insert --'
o.smd = false
-- no swap file
o.swf = false
-- use 24-bit color
o.tgc = true

-- conceal level
o.cole = 2
-- no word wrap
o.wrap = false
-- enable mouse
o.mouse = 'a'
-- highlight all search results
o.hlsearch = true

