local lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy) then
	local repo = "git@github.com:folke/lazy.nvim.git"
	-- latest stable release
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazy })
end
vim.opt.rtp:prepend(lazy)

local presence = {
	neovim_image_text = "Neovim",
	buttons = false,
}

local cmp = {
	"hrsh7th/nvim-cmp",
	config = require("plugins.cmp"),
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"saadparwaiz1/cmp_luasnip",
	},
}

local treesitter = {
	"nvim-treesitter/nvim-treesitter",
	config = require("plugins.treesitter"),
	dependencies = {
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}

local noice = {
	"folke/noice.nvim",
	opts = require("plugins.noice"),
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
}

local typst = {
	-- invert_colors = "always",
	-- debug = true,
	port = 8080,
	get_root = function()
		return vim.fn.getcwd()
	end,
}

require("lazy").setup({
	noice,
	{
		'Julian/lean.nvim',
		event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
		opts = { mappings = true }
	},
	{ "floaterest/typst-preview.nvim", ft = "typst", opts = typst },
	-- { "willothy/flatten.nvim", opts = {nest_if_no_args=true}, lazy = false, priority = 1001 },
	-- { "zbirenbaum/copilot.lua", config = require("plugins.copilot") },
	-- { "AndreM222/copilot-lualine" },
	-- { "zbirenbaum/copilot-cmp", opts = {} },
	-- { "andweeb/presence.nvim", opts = presence },
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	{ "akinsho/bufferline.nvim", opts = {} },
	{ "folke/which-key.nvim", config = require("plugins.which") },
	{ "ggandor/leap.nvim", config = require("plugins.leap") },
	{ "goolord/alpha-nvim", config = require("plugins.alpha") },
	{ "kyazdani42/nvim-tree.lua", opts = require("plugins.nvim-tree") },
	{ "kylechui/nvim-surround", opts = {} },
	{ "L3MON4D3/LuaSnip", config = require("plugins.luasnip") },
	{ "lewis6991/gitsigns.nvim", opts = require("plugins.gitsigns") },
	{ "neovim/nvim-lspconfig", config = require("plugins.lsp") },
	{ "numToStr/Comment.nvim", config = require("plugins.comment") },
	{ "nvim-lualine/lualine.nvim", opts = require("plugins.lualine") },
	{ "nvim-telescope/telescope.nvim", opts = require("plugins.telescope") },
	{ "nvimtools/none-ls.nvim", config = require("plugins.none") },
	{ "Shatur/neovim-session-manager", config = require("plugins.session") },
	{ "stevearc/dressing.nvim", opts = {} },
	{ "windwp/nvim-autopairs", config = require("plugins.autopairs") },
	cmp,
	treesitter,
})
