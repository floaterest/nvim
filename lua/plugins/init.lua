local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy) then
    local repo = 'git@github.com:folke/lazy.nvim.git'
    -- latest stable release
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazy })
end
vim.opt.rtp:prepend(lazy)

require('lazy').setup({
    'hrsh7th/cmp-buffer',
    { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true },
    { 'hrsh7th/cmp-nvim-lsp', lazy = true },
    { 'hrsh7th/cmp-nvim-lua', lazy = true },
    'hrsh7th/nvim-cmp',
    'kylechui/nvim-surround',
    'L3MON4D3/LuaSnip',
    'numToStr/Comment.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'saadparwaiz1/cmp_luasnip',
    'windwp/nvim-autopairs',

    { 'neovim/nvim-lspconfig', lazy = true },
    { 'jose-elias-alvarez/null-ls.nvim', lazy = true },
    -- 'mfussenegger/nvim-dap',
    -- 'rcarriga/nvim-dap-ui',
    -- 'mfussenegger/nvim-dap-python',

    'akinsho/bufferline.nvim',
    'ggandor/leap.nvim',
    'folke/which-key.nvim',
    'kyazdani42/nvim-tree.lua',
    'kyazdani42/nvim-web-devicons',

    'stevearc/dressing.nvim',
    'lewis6991/gitsigns.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'lukas-reineke/virt-column.nvim',
    'nvim-lualine/lualine.nvim',
    { 'nvim-treesitter/playground', lazy = true },
    'petertriho/nvim-scrollbar',
    'uga-rosa/ccc.nvim',
    'nvim-treesitter/nvim-treesitter',
})


-- prepare keymaps first
local which = require('plugins.whichkey')
local register = which.register

-- plugin setups, sorted alphabetically
-- require('plugins.external.dap')(register, which.dap)
-- require('plugins.external.dapui')(register, which.dapui)
require('plugins.external.lsp')(register, which.attach)
require('plugins.external.null')(register, which.attach)
require('leap').add_default_mappings()

require('plugins.behavior.autopairs')
require('plugins.behavior.cmp')(which.cmp)
require('plugins.behavior.comment')
require('plugins.behavior.luasnip')
require('plugins.behavior.surround')
require('plugins.behavior.telescope')(register, which.telescope)

require('plugins.interface.bufferline')
require('plugins.interface.ccc')
require('plugins.interface.gitsigns')
require('plugins.interface.indentline')
require('plugins.interface.lualine')
require('plugins.interface.nvim-tree')(register, which.nvimtree)
require('plugins.interface.scrollbar')
require('plugins.interface.treesitter')
require('plugins.interface.virtcolumn')
