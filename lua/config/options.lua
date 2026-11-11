-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "100" -- Vertical line after 100 chars
vim.opt.winborder = "rounded"
vim.opt.title = true
vim.opt.titlestring = " %t"
vim.opt.showtabline = 2 -- Always show tab bar
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  space = "·",
  eol = "↴",
}
