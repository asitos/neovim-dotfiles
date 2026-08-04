# neovim config

personal neovim configuration files

## plugins

<div align="center">

| plugin | purpose |
|--------|---------|
| [arduino.nvim](https://github.com/yuukiflow/Arduino-Nvim) | arduino development support |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | autocompletion |
| [barbar.nvim](https://github.com/romgrk/barbar.nvim) | tab/buffer line |
| [dashboard.nvim](https://github.com/nvimdev/dashboard-nvim) | start screen |
| [flash.nvim](https://github.com/folke/flash.nvim) | fast navigation & jump motions |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | lsp configuration |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | plugin manager |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | status line |
| [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim) | obsidian vault integration |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | file explorer as a buffer |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | rendered markdown in buffer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | fuzzy finder |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | floating/persistent terminal |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | syntax highlighting & parsing |
| [treesj](https://github.com/Wansmer/treesj) | split/join blocks of code |
| [twilight](https://github.com/folke/twilight.nvim) | dim inactive lines of code |

</div>

---

## colours used

catppuccin theme with slight modifications

```lua
local colors = {
  base     = '#1e1e2e', -- dark navy/charcoal (main background color)
  overlay0 = '#6c7086', -- muted grayish-blue (comments, subtle borders, tertiary overlays)
  text     = '#cdd6f4', -- light lavender-tinted white (primary default text)
  mauve    = '#cba6f7', -- pastel purple (keywords, conditionals, control structures)
  lavender = '#b4befe', -- soft periwinkle/blue-purple (secondary accents, variables, cursors)
  peach    = '#fab387', -- pastel orange/peach (properties, attributes, numbers)
  green    = '#a6e3a1', -- soft mint green (strings, git additions, success states)
  red      = '#f38ba8', -- pastel coral/red (errors, git deletions, dynamic variables)
}
```
