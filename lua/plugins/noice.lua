-- ~/.config/nvim/lua/plugins/noice.lua

return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "shell_out",
          },
          view = "popup",
        },
      },
    },
  },
}
