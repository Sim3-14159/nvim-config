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

    vim.api.nvim_create_user_command("NeorgClearDone", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local new_lines = {}
      local count = 0

      for _, line in ipairs(lines) do
        if line:match("%-%s*%(%[%_x%]%)") then
          count = count + 1
        else
          table.insert(new_lines, line)
        end
      end

      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
      print("Removed " .. count .. " completed tasks!")
    end, { desc = "Remove completed (x) tasks" })

    vim.keymap.set("n", "<LocalLeader>nd", ":NeorgClearDone<CR>", { silent = true })
  end,
})
