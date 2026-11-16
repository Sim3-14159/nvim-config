return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  dependencies = {
    "nvim-orgmode/org-bullets.nvim",
    "lukas-reineke/headlines.nvim",
  },
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
      org_hide_emphasis_markers = true,
    })

    require("org-bullets").setup()
    require("headlines").setup()

    -- Experimental LSP support
    vim.lsp.enable("org")
  end,
}
