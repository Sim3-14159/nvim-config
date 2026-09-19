return {
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

      -- Ensure sign column bg matches #111111 so signs pop with maximum contrast
      hl(0, "SignColumn", { bg = "#111111" })

      -- 100% saturation max-brightness RGB foregrounds
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
