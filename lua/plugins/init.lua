local install = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer = 'git@github.com:wbthomason/packer.nvim'
local cmd = { 'git', 'clone', '--depth', '1', packer, install }
local bootstrap = vim.fn.empty(vim.fn.glob(install)) > 0 and vim.fn.system(cmd)

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/nvim-cmp'
    use 'kylechui/nvim-surround'
    use 'L3MON4D3/LuaSnip'
    use 'numToStr/Comment.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'saadparwaiz1/cmp_luasnip'
    use 'windwp/nvim-autopairs'

    use 'jose-elias-alvarez/null-ls.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'mfussenegger/nvim-dap'
    use 'neovim/nvim-lspconfig'
    use 'rcarriga/nvim-dap-ui'

    use 'akinsho/bufferline.nvim'
    use 'ggandor/leap.nvim'
    use 'folke/which-key.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    -- use {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --       require("copilot").setup({
    --         suggestion = { enabled = false },
    --         panel = { enabled = false },
    --       })
    --     end,
    --   }
    -- use {
    --   "zbirenbaum/copilot-cmp",
    --   after = { "copilot.lua" },
    --   config = function ()
    --     require("copilot_cmp").setup()
    --   end
    -- }

    -- use 'github/copilot.vim'
    -- use 'hrsh7th/cmp-copilot'
    use 'stevearc/dressing.nvim'
    use 'lewis6991/gitsigns.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    use 'lukas-reineke/indent-blankline.nvim'
    use 'lukas-reineke/virt-column.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-treesitter/playground'
    use 'petertriho/nvim-scrollbar'
    use 'uga-rosa/ccc.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    if bootstrap then require('packer').sync() end
end)

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

vim.g.copilot_filetypes = {
    xml = false,
    markdown = false,
    json = false,
}