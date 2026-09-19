return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false, -- Disables Mason management for clangd and uses system PATH
        },
      },
    },
  },
}
