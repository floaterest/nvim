-- require("colo")
require("autocmd")
require("options")
require("plugins")

vim.cmd.colo('custom')

-- see log in ~/.local/state/nvim/lsp.log
-- vim.lsp.set_log_level("debug")

if vim.g.neovide then
	require("neovide")
end

vim.g.do_filetype_lua = 1
