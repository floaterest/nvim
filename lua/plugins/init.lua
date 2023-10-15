local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy) then
    local repo = 'git@github.com:folke/lazy.nvim.git'
    -- latest stable release
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazy })
end
vim.opt.rtp:prepend(lazy)

require('lazy').setup({
    -- 'mfussenegger/nvim-dap-python',
    -- 'mfussenegger/nvim-dap',
    -- 'rcarriga/nvim-dap-ui',
    'akinsho/bufferline.nvim',
    'folke/which-key.nvim',
    'ggandor/leap.nvim',
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    'kyazdani42/nvim-tree.lua',
    'kyazdani42/nvim-web-devicons',
    'kylechui/nvim-surround',
    'L3MON4D3/LuaSnip',
    'lewis6991/gitsigns.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'lukas-reineke/virt-column.nvim',
    'numToStr/Comment.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
    'petertriho/nvim-scrollbar',
    'saadparwaiz1/cmp_luasnip',
    'stevearc/dressing.nvim',
    'uga-rosa/ccc.nvim',
    'windwp/nvim-autopairs',
    { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
    { 'hrsh7th/cmp-nvim-lsp', lazy = true },
    { 'hrsh7th/cmp-nvim-lua', lazy = true },
    { 'jose-elias-alvarez/null-ls.nvim', lazy = true },
    { 'neovim/nvim-lspconfig', lazy = true },
    { 'nvim-treesitter/playground', lazy = true },
})


-- prepare keymaps first
local which = require('plugins.whichkey')
local register = which.register

-- plugin setups, sorted alphabetically
-- require('plugins.dap')(register, which.dap)
-- require('plugins.dapui')(register, which.dapui)
require('plugins.lsp')(register, which.attach)
require('plugins.null')(register, which.attach)
require('leap').add_default_mappings()

require('plugins.autopairs')
require('plugins.cmp')(which.cmp)
require('plugins.comment')
require('plugins.luasnip')
require('plugins.surround')
require('plugins.telescope')(register, which.telescope)

require('plugins.bufferline')
require('plugins.ccc')
require('plugins.gitsigns')
require('plugins.indentline')
require('plugins.lualine')
require('plugins.nvim-tree')(register, which.nvimtree)
require('plugins.scrollbar')
require('plugins.treesitter')
require('plugins.virtcolumn')
