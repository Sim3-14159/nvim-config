-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function setup_norg_keymaps(buf)
  vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {
    buffer = buf,
    desc = "Neorg: Cycle Todo Item",
  })

  vim.api.nvim_buf_create_user_command(buf, "NeorgClearDone", function()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local remaining = {}
    local count = 0

    for _, line in ipairs(lines) do
      if line:match("^%s*%- %([xX]%)") then
        count = count + 1
      else
        table.insert(remaining, line)
      end
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, remaining)
    print("Removed " .. count .. " completed tasks!")
  end, { desc = "Remove completed (x) tasks", force = true })

  vim.keymap.set("n", "<LocalLeader>nd", "<cmd>NeorgClearDone<CR>", {
    buffer = buf,
    silent = true,
    desc = "Neorg: Remove completed tasks",
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function(event)
    setup_norg_keymaps(event.buf)
  end,
})

if vim.bo.filetype == "norg" then
  setup_norg_keymaps(0)
end
