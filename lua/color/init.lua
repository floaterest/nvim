local colors = require((...) .. '.colors')
local highlights = require((...) .. '.highlights')

local styles = { i = 'italic', u = 'underline', b = 'bold' }

local function hi(group, line)
    if line:sub(1, 1) == '@' then
        return vim.api.nvim_set_hl(0, group, { link = line:sub(2) })
    end

    local line = line:gsub('-', 'NONE')
    local iter = line:gmatch('[^%s]+')
    local opts = {
        fg = colors[iter()],
        bg = colors[iter()],
    }
    local style = iter()
    if style then
        for c in style:gmatch('.') do
            if styles[c] then
                opts[styles[c]] = true
            end
        end
    end
    vim.api.nvim_set_hl(0, group, opts)
end

return {
    load = function()
        vim.cmd.hi('clear')

        if vim.fn.exists('syntax_on') then
            vim.cmd.syn('reset')
        end

        vim.o.bg = 'dark'
        vim.g.colors_name = 'custom'

        for group, line in pairs(highlights) do
            hi(group, line)
        end
    end,
}
