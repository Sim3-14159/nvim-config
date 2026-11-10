return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Add your core parsers here (do NOT add "norg")
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "lua",
        "vim",
        "vimdoc",
        "query",
      })

      opts.indent = opts.indent or {}
      opts.indent.disable = opts.indent.disable or {}
      if not vim.tbl_contains(opts.indent.disable, "c") then
        table.insert(opts.indent.disable, "c")
      end
    end,
  },
}
