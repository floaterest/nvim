# Plugins

> summary of plugins (managed by [packer](https://github.com/wbthomason/packer.nvim)) installed for this config, referencing [lua/plugins/init.lua](../lua/plugins/init.lua)

- the following are sorted based on file structure in [lua/plugins](../lua/plugins)
- plugins are listed by lua package name, hyperlinked to their GitHub repository

## Keymaps
> exports keymaps to other plugins

The custom keymaps are inspired by [Spacemacs](https://www.spacemacs.org/). That's why most of them starts with space

- [lua/plugins/whichkey.lua](../lua/plugins/whichkey.lua) will export all the keymaps to other plugins
- [lua/plugins/keymaps/](../lua/plugins/keymaps/) contains the keymaps that whichkey.lua exports with

## Behavior

> plugins that change the editing behavior of neovim

- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) inserts closing pair
  - cmp manages `<cr>` mapping
- [cmp](https://github.com/hrsh7th/nvim-cmp) provides completion
  - uses luasnip and nvim-autopairs
- [Comment](https://github.com/numToStr/Comment.nvim) makes comments
- [luasnip](https://github.com/L3MON4D3/LuaSnip) provides (auto)snippets based on filetype
- [nvim-surround](https://github.com/kylechui/nvim-surround) supports add/change/delete surrounding pairs
- [neoscroll](https://github.com/karb94/neoscroll.nvim) gives smooth scrolling
- [telescope](https://github.com/nvim-telescope/telescope.nvim) finds files

## External
> plugins that rely on external tools

the needed external tools should be installed globally as NPM packages unless specified

- [lspconfig](https://github.com/neovim/nvim-lspconfig) provides LSP support
  - [tsserver](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver) needs `typescript` and `typescript-language-server`
  - [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright) needs `pyright`
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) makes other tools to become languages servers
  - [eslint_d](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#eslint_d-2) needs `eslint_d`, and all the plugins required in `.eslintrc` needs to be installed locally in the same directory as it (e.g. if `~/.eslintrc.yaml`, then `~/node_modules` and ~/package.json`) ([issue](https://github.com/eslint/eslint/issues/11914))
  - [blue](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#blue) needs `blue` to be installed with `pip`, and `/home/{user}/.local/bin` should be in `PATH`
  - [stylua](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#stylua) needs `stylua` in `$PATH` (e.g. in `~/.local/bin`) from [releases](https://github.com/JohnnyMorganz/StyLua/releases)

## Interface
> plugins that provides useful interfaces

- [bufferline](https://github.com/akinsho/bufferline.nvim) shows buffers at the top of the window
- [indent_blankline](https://github.com/lukas-reineke/indent-blankline.nvim) shows indent level
- [lualine](https://github.com/nvim-lualine/lualine.nvim) shows editor status at the bottom of the buffer
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) gives better syntax highlighting through [AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree)
- [scrollbar](https://github.com/petertriho/nvim-scrollbar) shows scroll bar with diagnostics
- [which-key](https://github.com/folke/which-key.nvim) shows possible key shortcuts to help with my goldfish memory

