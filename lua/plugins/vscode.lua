return {
  -- Configure statusline (Lualine) with warm colors
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = {
        normal = {
          a = { bg = "#FF8C00", fg = "#111111", gui = "bold" }, -- Warm Amber for Normal mode
          b = { bg = "#252526", fg = "#CCCCCC" },
          c = { bg = "#111111", fg = "#CCCCCC" },
        },
        insert = {
          a = { bg = "#00FF00", fg = "#111111", gui = "bold" }, -- Bright Green for Insert mode
        },
        visual = {
          a = { bg = "#FF007F", fg = "#FFFFFF", gui = "bold" }, -- Pink/Magenta for Visual mode
        },
        replace = {
          a = { bg = "#FF3D00", fg = "#111111", gui = "bold" }, -- Orange-Red for Replace mode
        },
        command = {
          a = { bg = "#FFFF00", fg = "#111111", gui = "bold" }, -- Yellow for Command mode
        },
        inactive = {
          a = { bg = "#111111", fg = "#666666" },
          b = { bg = "#111111", fg = "#666666" },
          c = { bg = "#111111", fg = "#666666" },
        },
      }
    end,
  },

  -- Colorscheme configuration
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      italic_comments = true,
      color_overrides = {
        vscBack = "#111111",
      },
    },
    config = function(_, opts)
      local vscode = require("vscode")
      vscode.setup(opts)
      vscode.load()

      local hl = vim.api.nvim_set_hl

      -- Keep sign column background aligned with #111111
      hl(0, "SignColumn", { bg = "#111111" })

      -- Maximum brightness Git signs
      hl(0, "GitSignsAdd", { fg = "#00FF00", bold = true }) -- Pure Green
      hl(0, "GitSignsChange", { fg = "#00FFFF", bold = true }) -- Pure Cyan
      hl(0, "GitSignsDelete", { fg = "#FF0000", bold = true }) -- Pure Red
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
