local groups = { custom = {
    FocusGained = function() vim.cmd('checktime') end,
    [{ 'FocusLost', 'BufLeave' }] = function()
        if vim.api.nvim_eval('&ft') == 'NvimTree' then return end
        vim.cmd('w')
    end
} }

for group, commands in pairs(groups) do
    vim.api.nvim_create_augroup(group, { clear = true })
    for events, callback in pairs(commands) do
        local opts = { group = group, callback = callback }
        vim.api.nvim_create_autocmd(events, opts)
    end
end
