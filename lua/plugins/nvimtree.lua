-- vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
--     git = {
-- 		unstaged = "✗",
-- 		staged = "✓",
-- 		unmerged = "",
-- 		renamed = "➜",
-- 		untracked = "★",
-- 		deleted = "",
-- 		ignored = ''
--       },
--     folder = {
--       	arrow_open = "",
-- 		arrow_closed = "",
-- 		default = "",
-- 		open = "",
-- 		empty = "",
-- 		empty_open = "",
-- 		symlink = "",
-- 		symlink_open = "",
-- 	}
}		

local cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup({
    update_cwd = true,
	update_focused_file = { enable = true },
	-- git = { enabled = false, ignore = true },
    view = {
        auto_resize = true,
        mappings = {
            list = {
                { key = 'O', cb = cb('cd') }
            }
        }
    },
    renderer = {
        indent_markers = { enable = true }
    }
})

vim.api.nvim_set_keymap('n', '<c-n>', ':NvimTreeToggle<cr>', { noremap = true })
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")