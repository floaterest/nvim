# nvim

My neovim config (uses neovide)

# Structure

in `lua/`

- [`neovide.lua`](lua/neovide.lua) contains settings for [neovide](https://github.com/neovide/neovide)
- [`colorscheme/`](lua/colorscheme/) contains my custom colorscheme
  - too lazy to create separate repo
  - gray shades are defined using the CDF of [Beta(α=1, β=1)](https://en.wikipedia.org/wiki/Beta_distribution) 
  - details explained in [`colors.lua`](lua/colorscheme/colors.lua)
- [`core/`](lua/core/) contains general settings of neovim
- [`plugins/`](lua/plugins/) contains plugin settings


