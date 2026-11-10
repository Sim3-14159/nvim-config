return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-neorg/tree-sitter-norg",
      "nvim-neorg/tree-sitter-norg-meta",
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond", -- Options: "basic", "diamond", "folded"
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
}
