local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lua/plenary.nvim'

    use 'windwp/nvim-autopairs'
    use 'ur4ltz/surround.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim'
	use 'akinsho/bufferline.nvim'
	use 'folke/which-key.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'numToStr/Comment.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'L3MON4D3/LuaSnip'

    if packer_bootstrap then require('packer').sync() end
end)

-- plugin setups
require('plugins.autopairs')
require('plugins.indentline')
require('plugins.treesitter')
require('plugins.lualine')
require('plugins.whichkey')
require('plugins.bufferline')
require('plugins.telescope')
require('plugins.nvimtree')
require('plugins.comment')
require('plugins.luasnip')
require('plugins.surround')
