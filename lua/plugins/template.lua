return {
  "nvimdev/template.nvim",
  cmd = { "Template", "TemProject" },
  config = function()
    require("template").setup({
      temp_dir = vim.fn.expand("~/.config/nvim/templates"),
      author = "Sim3-14159",
    })
  end,
}
