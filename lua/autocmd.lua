local commands = {
    FocusGained = function() vim.cmd('checktime') end,
    [{ 'FocusLost', 'BufLeave', 'InsertLeave' }] = function(args)
        -- modified file with no buftype
        if vim.fn.getbufinfo(args.buf)[1].changed == 1 and vim.bo.bt == '' then
            vim.cmd.w()
        end
    end
    -- enable autoread
    CursorHold = function() vim.cmd.checkt() end,
}

local group = 'custom'
vim.api.nvim_create_augroup(group, { clear = true })
for events, callback in pairs(commands) do
    local opts = { group = group, callback = callback }
    -- https://neovim.io/doc/user/api.html#api-autocmd
    vim.api.nvim_create_autocmd(events, opts)
end
