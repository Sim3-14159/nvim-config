-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function(event)
    vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {
      buffer = event.buf,
      desc = "Neorg: Cycle Todo Item",
    })
  end,
})
