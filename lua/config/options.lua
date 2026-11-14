-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.exrc = true
vim.opt.colorcolumn = "100" -- Vertical line after 100 chars
vim.opt.winborder = "rounded"
vim.opt.title = true
vim.opt.titlestring = " %t"
vim.opt.showtabline = 2 -- Always show tab bar
vim.opt.list = true
vim.opt.conceallevel = 2
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

-- Set background and text color for inline errors
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b1d22", fg = "#f38ba8" })

-- Optional: Configure other inline diagnostic levels to match
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b321d", fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#1d2d3b", fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1d3b32", fg = "#94e2d5" })

-- Replace "#4d3800" with your preferred hex background color
vim.api.nvim_set_hl(0, "NeominimapWarnLine", { bg = "#3b321d" })
vim.api.nvim_set_hl(0, "NeominimapErrorLine", { bg = "#3b1d22" })
