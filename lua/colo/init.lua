local colors = require((...) .. '.colors')
local syn = require((...) .. '.syntax')

local styles = {
    i = 'italic',
    u = 'underline',
    b = 'bold'
}

local function hi(group, line)
    local cmd = line:sub(1,1) == '@' and { 'hi!', 'link' } or { 'hi' }
    cmd[#cmd + 1] = group

    -- if link
    if line:sub(1,1) == '@' then
        cmd[#cmd + 1] = line:sub(2)
    else
        local t = {}
        for s in line:gmatch('[^%s]+') do
            t[#t + 1] = s
        end
        cmd[#cmd + 1] = t[1] == '.' and '' or ('guifg=' .. (t[1] == '-' and 'NONE' or colors[t[1]]))
        cmd[#cmd + 1] = t[2] == '.' and '' or ('guibg=' .. (t[2] == '-' and 'NONE' or colors[t[2]]))
        cmd[#cmd + 1] = t[3] == '.' and '' or ('gui=' .. (t[3] == '-' and 'NONE' or styles[t[3]]))
    end

    vim.cmd(table.concat(cmd, ' '))
end

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then vim.cmd('syn reset') end

vim.o.bg = 'dark'
vim.o.tgc = true
vim.g.colors_name = 'custom'

for _, highlight in pairs(syn) do
    for group, line in pairs(highlight) do
        hi(group, line)
    end
end
