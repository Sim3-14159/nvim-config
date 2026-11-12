-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "100" -- Vertical line after 100 chars
vim.opt.winborder = "rounded"
vim.opt.title = true
vim.opt.titlestring = " %t"
vim.opt.showtabline = 2 -- Always show tab bar
vim.opt.list = true
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.softtabstop = 4
vim.opt.listchars = {
  tab = " ",
  trail = "·",
}
vim.opt.termguicolors = true
vim.b.terminal_color_0 = "#0f0f0f" -- black
vim.b.terminal_color_1 = "#a51d2d" -- red
vim.b.terminal_color_2 = "#278136" -- green
vim.b.terminal_color_3 = "#e5a50a" -- yellow
vim.b.terminal_color_4 = "#1a5fb4" -- blue
vim.b.terminal_color_5 = "#a523a5" -- magenta
vim.b.terminal_color_6 = "#199c8f" -- cyan
vim.b.terminal_color_7 = "#77767b" -- white

vim.b.terminal_color_8 = "#3d3846" -- bright black
vim.b.terminal_color_9 = "#ff0000" -- bright red
vim.b.terminal_color_10 = "#00ff00" -- bright green
vim.b.terminal_color_11 = "#ffff00" -- bright yellow
vim.b.terminal_color_12 = "#5c5cff" -- bright blue
vim.b.terminal_color_13 = "#ff00ff" -- bright magenta
vim.b.terminal_color_14 = "#00ffff" -- bright cyan
vim.b.terminal_color_15 = "#ffffff" -- bright white
