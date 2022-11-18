local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1', 
        'https://github.com/wbthomason/packer.nvim', install_path
    })
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'

    use "hrsh7th/nvim-cmp"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-calc"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-path"

    use 'windwp/nvim-autopairs'
	use 'akinsho/bufferline.nvim'
    use 'numToStr/Comment.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
    use 'L3MON4D3/LuaSnip'
    use 'ur4ltz/surround.nvim'
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'folke/which-key.nvim'

    if packer_bootstrap then require('packer').sync() end
end)

-- plugin setups
require('plugins/external/mason')

require('plugins/behavior/autopairs')
require('plugins/behavior/comment')
require('plugins/behavior/luasnip')
require('plugins/behavior/surround')
require('plugins/behavior/telescope')
require('plugins/behavior/cmp')

require('plugins/interface/bufferline')
require('plugins/interface/indentline')
require('plugins/interface/lualine')
require('plugins/interface/treesitter')
require('plugins/interface/whichkey')
