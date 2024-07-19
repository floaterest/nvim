local config = require('plugins._config')
local lazy = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazy) then
    local repo = 'git@github.com:folke/lazy.nvim.git'
    -- latest stable release
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        repo,
        '--branch=stable',
        lazy,
    })
end
vim.opt.rtp:prepend(lazy)

local function req(path)
    return function()
        require(path)
    end
end

local noice = require('lazy').setup({
    { 'floaterest/typst-preview.nvim', ft = 'typst', opts = config.typst },
    { 'L3MON4D3/LuaSnip', config = req('plugins.luasnip') },
    { 'Shatur/neovim-session-manager', config = config.session },
    { 'akinsho/bufferline.nvim', opts = config.bufferline },
    { 'folke/which-key.nvim', config = req('plugins.which') },
    { 'ggandor/leap.nvim', config = config.leap },
    { 'goolord/alpha-nvim', config = req('plugins.alpha') },
    { 'kyazdani42/nvim-tree.lua', opts = config.tree },
    { 'kyazdani42/nvim-web-devicons', lazy = false },
    { 'kylechui/nvim-surround', opts = {} },
    { 'lewis6991/gitsigns.nvim', opts = config.gitsigns },
    { 'neovim/nvim-lspconfig', config = req('plugins.lsp') },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'nvim-lua/plenary.nvim', lazy = false },
    { 'nvim-lualine/lualine.nvim', opts = req('plugins.lualine') },
    { 'nvim-telescope/telescope.nvim', opts = {} },
    { 'nvimtools/none-ls.nvim', config = req('plugins.none') },
    { 'stevearc/dressing.nvim', opts = {} },
    { 'windwp/nvim-autopairs', config = req('plugins.autopairs') },
    {
        'hrsh7th/nvim-cmp',
        config = require('plugins.cmp'),
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = require('plugins.treesitter'),
        dependencies = {
            'nvim-treesitter/playground',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },
    {
        'folke/noice.nvim',
        opts = require('plugins.noice'),
        dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    },
})
