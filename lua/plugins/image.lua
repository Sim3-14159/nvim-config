return {
  {
    "3rd/image.nvim",
    cond = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
    dependencies = { "vhyrro/luarocks.nvim" }, -- Required for luarocks image bindings
    opts = {
      backend = "kitty", -- Force the kitty graphics protocol backend
      integrations = {
        markdown = {
          enabled = true,
          clear_in_cursor_leaf = true,
          download_remote_images = true,
          only_render_image_at_cursor = false,
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
    },
  },
}
