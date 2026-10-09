return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        trigger = {
          show_on_keyword = false,
        },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_active() then
              return
            end

            local cursor = vim.api.nvim_win_get_cursor(0)
            local prefix = vim.api.nvim_get_current_line():sub(1, cursor[2])
            if prefix ~= "" and vim.fn.match(prefix, [[\k$]]) >= 0 then
              cmp.show()
              return true
            end
          end,
          "select_and_accept",
          "fallback",
        },
        ["<CR>"] = { "fallback" },
      },
    },
  },
}
