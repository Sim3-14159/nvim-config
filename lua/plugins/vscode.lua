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

          hl(0, "FloatBorder", {
            bg = "#111111",
          })
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
      vim.g.terminal_color_0 = "#0f0f0f" -- black
      vim.g.terminal_color_1 = "#a51d2d" -- red
      vim.g.terminal_color_2 = "#278136" -- green
      vim.g.terminal_color_3 = "#e5a50a" -- yellow
      vim.g.terminal_color_4 = "#1a5fb4" -- blue
      vim.g.terminal_color_5 = "#a523a5" -- magenta
      vim.g.terminal_color_6 = "#199c8f" -- cyan
      vim.g.terminal_color_7 = "#77767b" -- white

      vim.g.terminal_color_8 = "#3d3846" -- bright black
      vim.g.terminal_color_9 = "#ff0000" -- bright red
      vim.g.terminal_color_10 = "#00ff00" -- bright green
      vim.g.terminal_color_11 = "#ffff00" -- bright yellow
      vim.g.terminal_color_12 = "#5c5cff" -- bright blue
      vim.g.terminal_color_13 = "#ff00ff" -- bright magenta
      vim.g.terminal_color_14 = "#00ffff" -- bright cyan
      vim.g.terminal_color_15 = "#ffffff" -- bright white
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
