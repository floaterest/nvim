local lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy) then
	local repo = "git@github.com:folke/lazy.nvim.git"
	-- latest stable release
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazy })
end
vim.opt.rtp:prepend(lazy)

local presence = {
	neovim_image_text = "Neovim",
	-- enable_line_number=true,
	buttons = false,
}

require("lazy").setup({
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	{ "andweeb/presence.nvim", opts = presence },
	{ "zbirenbaum/copilot.lua", config = require("plugins.copilot") },
	{ "akinsho/bufferline.nvim", opts = {} },
	{ "folke/which-key.nvim", config = require("plugins.which") },
	{ "ggandor/leap.nvim", config = require("plugins.leap") },
	{ "goolord/alpha-nvim", config = require("plugins.alpha") },
	{ "kyazdani42/nvim-tree.lua", opts = require("plugins.nvim-tree") },
	{ "kylechui/nvim-surround", opts = {} },
	{ "AndreM222/copilot-lualine" },
	{ "L3MON4D3/LuaSnip", config = require("plugins.luasnip") },
	{ "lewis6991/gitsigns.nvim", opts = require("plugins.gitsigns") },
	{ "m4xshen/smartcolumn.nvim", opts = require("plugins.column") },
	{ "neovim/nvim-lspconfig", config = require("plugins.lsp") },
	{ "numToStr/Comment.nvim", config = require("plugins.comment") },
	{ "nvim-lualine/lualine.nvim", opts = require("plugins.lualine") },
	{ "nvim-telescope/telescope.nvim", opts = require("plugins.telescope") },
	{ "nvimtools/none-ls.nvim", config = require("plugins.none") },
	{ "Shatur/neovim-session-manager", config = require("plugins.session") },
	{ "stevearc/dressing.nvim", opts = {} },
	{ "windwp/nvim-autopairs", config = require("plugins.autopairs") },
	{ "zbirenbaum/copilot-cmp", opts = {} },
	{
		"hrsh7th/nvim-cmp",
		config = require("plugins.cmp"),
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = require("plugins.treesitter"),
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{
		"folke/noice.nvim",
		opts = require("plugins.noice"),
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
})

require("notify").setup({
    timeout = 1000,
})
