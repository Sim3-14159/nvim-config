return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.indent = opts.indent or {}
      opts.indent.disable = opts.indent.disable or {}
      if not vim.tbl_contains(opts.indent.disable, "c") then
        table.insert(opts.indent.disable, "c")
      end
    end,
  },
}
