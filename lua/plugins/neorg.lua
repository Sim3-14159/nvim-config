return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    build = "build.lua",
    opts = {
      rocks = {
        "lua-utils.nvim == 1.0.2",
        "nvim-nio ~> 1.7",
        "nui.nvim == 0.3.0",
        "pathlib.nvim ~> 2.2",
      },
    },
    config = function(_, opts)
      require("luarocks-nvim").setup(opts)
    end,
  },
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
      "3rd/image.nvim",
      "vhyrro/luarocks.nvim",
    },
    config = function()
      local rocks = vim.fn.stdpath("data") .. "/lazy-rocks"
      package.cpath = table.concat({
        package.cpath,
        rocks .. "/tree-sitter-norg/lib/lua/5.1/?.so",
        rocks .. "/tree-sitter-norg-meta/lib/lua/5.1/?.so",
      }, ";")

      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.tangle"] = {
            config = {
              tangle_on_write = true, -- Automatically syncs code blocks when saving the .norg file
            },
          },
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
              icon_preset = "varied", -- Options: "basic", "diamond", "varied"
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
