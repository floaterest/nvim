# Neovim

My neovim config (optionally uses neovide)

## lua/

- [lua/neovide.lua](lua/neovide.lua) contains settings for [neovide](https://github.com/neovide/neovide)
  - will be loaded iff neovim is opened from neovide

- [lua/core/](lua/core)
  - [o.lua](lua/core/o.lua) enables/disables options via `vim.o` in lua
  - [keymaps.lua](lua/core/keymaps.lua) exports all non-builtin keymaps to other lua scripts
- [lua/colo/](lua/colo)
  - [colors.lua](lua/colo/colors.lua) exports color names with their RGB values to other lua scripts to create a custom colorscheme
    - see [doc/colo.md](doc/colo.md) for details
  - [syntax.lua](lua/colo/syntax.lua) defines syntax highlightings with the colors from `colors.lua`
- [lua/plugins/](lua/plugins/) has too much to explain, see [doc/plugins.md](doc/plugins.md)
