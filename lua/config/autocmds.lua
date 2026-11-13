-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.cinkeys:remove("0#")
    vim.opt_local.formatoptions:remove("c")
    vim.opt_local.formatoptions:remove("o")
    vim.opt_local.formatoptions:append("r")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function(args)
    --Word wrap since it's text
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    -- Disable minimap for .norg files
    require("neominimap.api").buf.disable(args.buf)

    vim.opt.colorcolumn = "" -- No endline for .norg files
    vim.cmd("Neorg render-latex")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("CustomTerminalColors", { clear = true }),
  callback = function()
    -- 1. Make the main terminal background transparent so your outer terminal's bg shows through
    -- (Or replace 'NONE' with your terminal's exact hex color, e.g. '#000000')
    vim.api.nvim_set_hl(0, "TermNormal", { bg = "NONE" })
    vim.wo.winhighlight = "Normal:TermNormal,NormalNC:TermNormal"

    -- 2. Match ANSI codes (\033[45m, etc.) to your regular terminal's 16-color palette
    -- vim.b.terminal_color_0 = "#000000" -- Black
    -- vim.b.terminal_color_1 = "#cc0000" -- Red
    -- vim.b.terminal_color_2 = "#4e9a06" -- Green
    -- vim.b.terminal_color_3 = "#c4a000" -- Yellow
    -- vim.b.terminal_color_4 = "#3465a4" -- Blue
    -- vim.b.terminal_color_5 = "#75507b" -- Magenta (\033[45m)
    -- vim.b.terminal_color_6 = "#06989a" -- Cyan
    -- vim.b.terminal_color_7 = "#d3d7cf" -- White
    -- vim.b.terminal_color_0 = "#000000"
    -- vim.b.terminal_color_8 = "#767676"

    -- vim.b.terminal_color_1 = "#cc0403"
    -- vim.b.terminal_color_9 = "#f2201f"
    --
    -- vim.b.terminal_color_2 = "#19cb00"
    -- vim.b.terminal_color_10 = " #23fd00"
    --
    -- vim.b.terminal_color_3 = "#cecb00"
    -- vim.b.terminal_color_11 = " #fffd00"
    --
    -- vim.b.terminal_color_4 = "#0d73cc"
    -- vim.b.terminal_color_12 = " #1a8fff"
    --
    -- vim.b.terminal_color_5 = "#cb1ed1"
    -- vim.b.terminal_color_13 = " #fd28ff"
    --
    -- vim.b.terminal_color_6 = "#0dcdcd"
    -- vim.b.terminal_color_14 = " #14ffff"
    --
    -- vim.b.terminal_color_7 = "#dddddd"
    -- vim.b.terminal_color_15 = " #ffffff"

    vim.b.terminal_color_0 = "#0f0f0f"
    vim.b.terminal_color_1 = "#a51d2d"
    vim.b.terminal_color_2 = "#278136"
    vim.b.terminal_color_3 = "#e5a50a"
    vim.b.terminal_color_4 = "#1a5fb4"
    vim.b.terminal_color_5 = "#a523a5"
    vim.b.terminal_color_6 = "#199c8f"
    vim.b.terminal_color_7 = "#77767b"

    vim.b.terminal_color_8 = #"3d3846 "
    vim.b.terminal_color_9 = "#ff0000"
    vim.b.terminal_color_10 = "#00ff00"
    vim.b.terminal_color_11 = "#ffff00"
    vim.b.terminal_color_12 = "#5c5cff"
    vim.b.terminal_color_13 = "#ff00ff"
    vim.b.terminal_color_14 = "#00ffff"
    vim.b.terminal_color_15 = "#ffffff"
  end,
})

-- Autosave
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! wa")
    end
  end,
})

-- Background colors for inline error messages
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Set background and text color for inline errors
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b1d22", fg = "#f38ba8" })

    -- Optional: Configure other inline diagnostic levels to match
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b321d", fg = "#f9e2af" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#1d2d3b", fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1d3b32", fg = "#94e2d5" })

    -- Replace "#4d3800" with your preferred hex background color
    vim.api.nvim_set_hl(0, "NeominimapWarnLine", { bg = "#3b321d" })
    vim.api.nvim_set_hl(0, "NeominimapErrorLine", { bg = "#3b1d22" })
  end,
})

-- Set background and text color for inline errors
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "#3b1d22", fg = "#f38ba8" })

-- Optional: Configure other inline diagnostic levels to match
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "#3b321d", fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "#1d2d3b", fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "#1d3b32", fg = "#94e2d5" })

-- Replace "#4d3800" with your preferred hex background color
vim.api.nvim_set_hl(0, "NeominimapWarnLine", { bg = "#3b321d" })
vim.api.nvim_set_hl(0, "NeominimapErrorLine", { bg = "#3b1d22" })
