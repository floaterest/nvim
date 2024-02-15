local lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy) then
	local repo = "git@github.com:folke/lazy.nvim.git"
	-- latest stable release
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazy })
end
vim.opt.rtp:prepend(lazy)

require("lazy").setup({
	-- 'mfussenegger/nvim-dap-python',
	-- 'mfussenegger/nvim-dap',
	-- 'rcarriga/nvim-dap-ui',
	"akinsho/bufferline.nvim",
	{ "kylechui/nvim-surround", event = "VeryLazy" },
	"folke/which-key.nvim",
	"ggandor/leap.nvim",
	"goolord/alpha-nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/nvim-cmp",
	"windwp/nvim-autopairs",
	"Shatur/neovim-session-manager",
	"nvimtools/none-ls.nvim",
	"kdheepak/lazygit.nvim",
	"kyazdani42/nvim-tree.lua",
	"kyazdani42/nvim-web-devicons",
	"L3MON4D3/LuaSnip",
	"m4xshen/smartcolumn.nvim",
	"lewis6991/gitsigns.nvim",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"numToStr/Comment.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	"saadparwaiz1/cmp_luasnip",
	"stevearc/dressing.nvim",
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{ "echasnovski/mini.nvim", version = false },
})

-- prepare keymaps first
local which = require("plugins.whichkey")
local register = which.register
local lazygit = require("lazygit")
which.register({ ["<leader>gg"] = { lazygit.lazygit, "Open LazyGit" } })

-- plugin setups, sorted alphabetically
-- require('plugins.dap')(register, which.dap)
-- require('plugins.dapui')(register, which.dapui)
require("leap").add_default_mappings()
require("nvim-surround").setup({})
require("plugins.alpha")
require("plugins.autopairs")
require("plugins.comment")
require("plugins.bufferline")
require("plugins.cmp")(which.cmp)
require("plugins.gitsigns")
require("plugins.lsp")(register, which.attach)
require("plugins.lualine")
require("plugins.luasnip")
require("plugins.mini")
require("plugins.noice")
require("plugins.none")(register, which.attach)
require("plugins.nvim-tree")(register, which.nvimtree)
require("plugins.telescope")(register, which.telescope)
require("plugins.treesitter")

require("smartcolumn").setup({
	disabled_filetypes = {
		"tex",
		"alpha",
		"help",
		"text",
		"markdown",
	},
})

local config = require("session_manager.config")
require("session_manager").setup({
	autoload_mode = config.AutoloadMode.Disabled,
})
