-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g["conjure#log#hud#open_before_first_eval"] = false -- get rid of "sponsored" message
require("config.lazy")
vim.opt.title = true
vim.opt.titlestring = " %t"
vim.opt.conceallevel = 2 -- Hides markdown markers and styles headings

vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("auto_templates", { clear = true }),
  desc = "Automatically load templates and replace variables",
  callback = function(args)
    local template_dir = vim.fn.expand("~/.config/nvim/templates/")
    local filename = vim.fn.fnamemodify(args.file, ":t")
    local ext = vim.fn.fnamemodify(args.file, ":e")

    local template_path = nil
    local exact_match = template_dir .. filename
    if vim.fn.filereadable(exact_match) == 1 then
      template_path = exact_match
    elseif ext ~= "" then
      local ext_match = template_dir .. ext .. ".tpl"
      if vim.fn.filereadable(ext_match) == 1 then
        template_path = ext_match
      end
    end

    if template_path then
      -- 1. Read the template into the current buffer
      vim.cmd("0r " .. template_path)

      -- 2. Define the variables you want to inject
      local replacements = {
        ["{{_author_}}"] = "Sim3-14159",
        ["{{_email_}}"] = "EMAIL",
        ["{{_date_}}"] = os.date("%Y-%m-%d"),
        ["{{_file_name_}}"] = filename,
        ["{{_file_prefix_}}"] = string.match(filename, "^([^.]*)"),
        ["{{_year_}}"] = os.date("%Y"),
      }

      -- 3. Scan the buffer lines and replace placeholders
      local bufnr = args.buf
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for i, line in ipairs(lines) do
        for pattern, value in pairs(replacements) do
          line = line:gsub(pattern, value)
        end
        lines[i] = line
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    end
  end,
})

require("session_servers").setup() -- Set up :Connect and :Detach

-- NOTE: Uncomment this if you see random garbage at startup
-- https://github.com/neovim/neovim/issues/40988
--vim.g.termfeatures = vim.g.termfeatures or {}
--vim.g.termfeatures.osc52 = false
