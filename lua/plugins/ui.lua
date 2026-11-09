return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      -- Force the native Snacks header highlight group to Matrix Green
      local set_matrix_green = function()
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {
          fg = "#00FF66",
          ctermfg = 46, -- Fallback for 256-color terminals
          bold = true,
        })
      end

      -- Apply immediately on load
      set_matrix_green()

      -- Re-apply whenever the colorscheme reloads
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_matrix_green,
      })

      local function run_command(cmd)
        -- assert ensures the handle exists before proceeding
        local handle = assert(io.popen(cmd, "r"))
        local output = assert(handle:read("*a"))
        handle:close()

        -- Optional: Trim trailing whitespace/newlines
        output = string.gsub(output, "%s+$", "")
        return output
      end

      -- Set header text
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.header = [[
╭──────────────────────────────────────────────────────╮
│  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  │
│  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  │
│  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  │
│  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  │
│  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  │
│  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  │
╰──────────────────────────────────────────────────────╯
                       \   ^__^                         
                        \  (⯋⯋)\_______                 
                           (__)\       )\/\             
                               ||----w |                
                               ||     ||                

]] .. run_command(
        "while :; do f=$(fortune -s); case \"$f\" in *'\n'*) continue ;; esac; [ ${#f} -le 80 ] && printf '%s' \"$f\" && break; done"
      )
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true, -- Rounded borders on hover stuff
      },
    },
  },
}
