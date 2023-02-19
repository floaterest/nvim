local o = vim.o

-- reload file changes (autoread)
o.ar = true
-- keep visual indent on wrap
o.bri = true
-- allow backspace
o.bs = 'indent,eol,start'
-- set visual guide (colorcolumn)
o.cc = '80'
-- conceal level
o.cole = 2
-- complete option
o.cot = 'menuone,noinsert,noselect'
-- <tab> expands to spaces
o.et = true
-- format options
o.fo = 'jcrql'
-- allow multiple unsaved buffers
o.hid = true
-- highlight all search results
o.hls= true
-- case insensitive search
o.ic = true
-- enable mouse
o.mouse = 'a'
-- current line number
o.nu = true
-- relative line number
o.rnu = true
-- use case sensitive search iff search contains upper case letters
o.scs = true
-- don't syntax highlight after 500 lines
o.smc = 500
-- don't show '-- insert --'
o.smd = false
-- num of lines to keep above/below cursor
o.so = 8
-- spaces per tab
o.sts = 4
-- columns per shift
o.sw = 4
-- no swap file
o.swf = false
-- use 24-bit color
o.tgc = true
-- timeout in ms (e.g. for whichkey)
o.tm = 500
-- columns per tabstop
o.ts = 4
-- no word wrap
o.wrap = false
