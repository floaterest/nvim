local commands = {
    FocusGained = function()
        vim.cmd('checktime')
    end,
    [{ 'FocusLost', 'BufLeave', 'InsertLeave' }] = function(args)
        -- modified file with no buftype
        local info = vim.fn.getbufinfo(args.buf)[1]
        if info.changed == 0 or info.name == "" then
            return
        end
        vim.cmd('silent! w')
    end,
    TextYankPost = function() -- highlight yanked text
        vim.highlight.on_yank({ timeout = 500, on_visual = false })
    end,
    TermOpen = function()
        vim.opt_local.nu = false
        vim.opt_local.rnu = false
    end,
}

local group = 'custom'
vim.api.nvim_create_augroup(group, { clear = true })
for events, callback in pairs(commands) do
    local opts = { group = group, callback = callback }
    -- https://neovim.io/doc/user/api.html#api-autocmd
    vim.api.nvim_create_autocmd(events, opts)
end
