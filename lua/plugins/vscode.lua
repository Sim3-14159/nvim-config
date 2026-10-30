return {
  -- Configure statusline (Lualine) with warm colors
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = {
        normal = {
          a = { bg = "#FF8C00", fg = "#111111", gui = "bold" },
          b = { bg = "#252526", fg = "#CCCCCC" },
          c = { bg = "#000000", fg = "#CCCCCC" },
        },
        insert = {
          a = { bg = "#00FF00", fg = "#111111", gui = "bold" },
        },
        visual = {
          a = { bg = "#FF007F", fg = "#FFFFFF", gui = "bold" },
        },
        replace = {
          a = { bg = "#FF3D00", fg = "#111111", gui = "bold" },
        },
        command = {
          a = { bg = "#00FFFF", fg = "#111111", gui = "bold" },
        },
        inactive = {
          a = { bg = "#000000", fg = "#666666" },
          b = { bg = "#000000", fg = "#666666" },
          c = { bg = "#000000", fg = "#666666" },
        },
      }

      table.insert(opts.sections.lualine_y, { "filetype", icon = false })
    end,
  },

  -- VS Code colorscheme
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

      -- These overrides need to happen after the colorscheme/plugins
      -- have finished setting their own highlight groups.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "vscode",
        callback = function()
          local hl = vim.api.nvim_set_hl

          -- Sign column
          hl(0, "SignColumn", {
            bg = "#111111",
          })

          -- Git signs: intentionally bright/neon
          hl(0, "GitSignsAdd", {
            fg = "#00FF00",
            bold = true,
          })

          hl(0, "GitSignsChange", {
            fg = "#FFFF00",
            bold = true,
          })

          hl(0, "GitSignsDelete", {
            fg = "#FF0000",
            bold = true,
          })

          -- Git signs in the number column
          hl(0, "GitSignsAddNr", {
            fg = "#00FF00",
            bold = true,
          })

          hl(0, "GitSignsChangeNr", {
            fg = "#FFFF00",
            bold = true,
          })

          hl(0, "GitSignsDeleteNr", {
            fg = "#FF0000",
            bold = true,
          })

          -- Subtle background highlights for changed lines.
          -- These are intentionally much darker than the signs.
          hl(0, "GitSignsAddLn", {
            bg = "#003300",
          })

          hl(0, "GitSignsChangeLn", {
            bg = "#333300",
          })

          hl(0, "GitSignsDeleteLn", {
            bg = "#330000",
          })

          -- Warm popup borders
          -- hl(0, "FloatBorder", {
          --   fg = "#FF8C00",
          --   bg = "#111111",
          -- })
        end,
      })

      -- Rounded diagnostic popups
      vim.diagnostic.config({
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Terminal ANSI colors
      --
      -- These are deliberately NOT warm/muted. They make programs
      -- using ANSI colors inside Neovim's terminal retain strong,
      -- recognizable colors.
      vim.g.terminal_color_0 = "#111111" -- black
      vim.g.terminal_color_1 = "#FF0000" -- red
      vim.g.terminal_color_2 = "#00FF00" -- green
      vim.g.terminal_color_3 = "#FFFF00" -- yellow
      vim.g.terminal_color_4 = "#0000FF" -- blue
      vim.g.terminal_color_5 = "#FF00FF" -- magenta
      vim.g.terminal_color_6 = "#00FFFF" -- cyan
      vim.g.terminal_color_7 = "#FFFFFF" -- white

      vim.g.terminal_color_8 = "#666666" -- bright black
      vim.g.terminal_color_9 = "#FF5555" -- bright red
      vim.g.terminal_color_10 = "#55FF55" -- bright green
      vim.g.terminal_color_11 = "#FFFF55" -- bright yellow
      vim.g.terminal_color_12 = "#5555FF" -- bright blue
      vim.g.terminal_color_13 = "#FF55FF" -- bright magenta
      vim.g.terminal_color_14 = "#55FFFF" -- bright cyan
      vim.g.terminal_color_15 = "#FFFFFF" -- bright white
    end,
  },

  -- Make vscode the LazyVim colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
