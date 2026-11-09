return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          on_new_config = function(config, root_dir)
            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.venvPath = root_dir
            config.settings.python.venv = ".venv"
          end,
        },
      },
    },
  },
}
