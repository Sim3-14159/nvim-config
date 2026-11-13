return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
      "3rd/image.nvim",
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.integrations.image"] = {},
          ["core.highlights"] = {
            config = {
              highlights = {
                links = {
                  location = {
                    url = "+@markup.link.url",
                  },
                },
              },
            },
          },
          ["core.latex.renderer"] = {
            config = {
              conceal = true,
              render_on_enter = true, -- Renders automatically when opening a .norg file
            },
          },
          ["core.concealer"] = {
            config = {
              icon_preset = "varied", -- Options: "basic", "diamond", "folded"
              icons = {
                code_block = {
                  conceal = true,
                },
                todo = {
                  uncertain = {
                    icon = " ",
                  },
                  undone = {
                    icon = " ",
                  },
                  done = {
                    icon = " ",
                  },
                  urgent = {
                    icon = " ",
                  },
                  pending = {
                    icon = " ",
                  },
                  cancelled = {
                    icon = " ",
                  },
                  recurring = {
                    icon = "󱍷 ",
                  },
                  on_hold = {
                    icon = " ",
                  },
                },
              },
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Documents/Notes/",
              },
              default_workspace = "notes",
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "notes",
            },
          },
          ["core.ui.calendar"] = {},
        },
      })
    end,
  },
  {
    "neovim/nvim-treesitter",
    opts = function()
      vim.api.nvim_set_hl(0, "@markup.link.url", {
        underline = true,
      })
    end,
  },
}
