local M = {}

local session_dir = "/tmp/nvim-session-data"

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO)
end

local function ensure_dir()
  local ok = vim.fn.mkdir(session_dir, "p", "rwx------")

  if ok == -1 then
    error("Could not create " .. session_dir)
  end
end

local function session_path(server)
  return session_dir .. "/" .. vim.fn.sha256(server) .. ".json"
end

local function get_buffers()
  local buffers = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    -- Only look at loaded buffers that are actually listed in the buffer list
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)

      if name ~= "" then
        local buftype = vim.bo[buf].buftype
        local filename = vim.fn.fnamemodify(name, ":t")

        -- Blacklist patterns for logs, temp files, and internal scripts
        local is_excluded = filename:match("^conjure%-log") ~= nil
          or filename:match("filetype") ~= nil
          or name:match("^/tmp") ~= nil
          or name:match("^/var/tmp") ~= nil
          or name:match("fugitive://") ~= nil

        if buftype == "" and not is_excluded then
          table.insert(buffers, filename)
        end
      end
    end
  end

  return buffers
end

function M.detach()
  local server = vim.v.servername

  if server == "" then
    notify("This Neovim instance has no server address.", vim.log.levels.ERROR)
    return
  end

  local ok, err = pcall(function()
    ensure_dir()

    local session = {
      server = server,
      cwd = vim.fn.getcwd(),
      buffers = get_buffers(),
      timestamp = os.time(),
    }

    local path = session_path(server)
    local file, open_err = io.open(path, "w")

    if not file then
      error("Could not open session file: " .. tostring(open_err))
    end

    local write_ok, write_err = file:write(vim.json.encode(session))
    file:close()

    if not write_ok then
      error("Could not write session file: " .. tostring(write_err))
    end

    vim.uv.fs_chmod(path, 384)

    if not vim.uv.fs_stat(path) then
      error("Session file was not created.")
    end
  end)

  if not ok then
    notify("Detach failed: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  notify("Session saved. Detaching...")
  vim.cmd("detach")
end

local function read_sessions()
  ensure_dir()

  local files = vim.fn.globpath(session_dir, "*.json", false, true)
  local sessions = {}

  for _, path in ipairs(files) do
    local file = io.open(path, "r")

    if file then
      local contents = file:read("*a")
      file:close()

      local ok, session = pcall(vim.json.decode, contents)

      if ok and type(session) == "table" and type(session.server) == "string" and session.server ~= "" then
        session.path = path
        session.buffers = session.buffers or {}

        table.insert(sessions, session)
      else
        notify("Ignoring invalid session file: " .. path, vim.log.levels.WARN)
      end
    end
  end

  table.sort(sessions, function(a, b)
    return (a.timestamp or 0) > (b.timestamp or 0)
  end)

  return sessions
end

function M.connect()
  local ok, sessions = pcall(read_sessions)

  if not ok then
    notify("Could not read sessions: " .. tostring(sessions), vim.log.levels.ERROR)
    return
  end

  if #sessions == 0 then
    notify("No saved sessions found.")
    return
  end

  vim.ui.select(sessions, {
    prompt = "Connect to Neovim session:",
    format_item = function(session)
      local cwd = session.cwd or ""
      local project_name = vim.fn.fnamemodify(cwd, ":t")
      local display_cwd = project_name ~= "" and project_name or cwd

      local buf_str = #session.buffers > 0 and table.concat(session.buffers, ", ") or "no open buffers"

      return string.format("%s  |  %s", display_cwd, buf_str)
    end,
  }, function(choice)
    if not choice then
      return
    end

    local stat = vim.uv.fs_stat(choice.server)

    if not stat then
      notify("Server socket no longer exists: " .. choice.server, vim.log.levels.ERROR)
      return
    end

    local connect_ok, connect_err = pcall(function()
      vim.cmd({
        cmd = "connect",
        args = { choice.server },
      })
    end)

    if not connect_ok then
      notify("Connection failed: " .. tostring(connect_err), vim.log.levels.ERROR)
      return
    end

    os.remove(choice.path)
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("Detach", M.detach, {
    desc = "Save session metadata and detach",
  })

  vim.api.nvim_create_user_command("Connect", M.connect, {
    desc = "Pick and connect to a saved Neovim session",
  })

  vim.keymap.set("n", "<LocalLeader>sd", "<cmd>Detach<CR>", { desc = "Detach session" })
  vim.keymap.set("n", "<LocalLeader>sc", "<cmd>Connect<CR>", { desc = "Connect to session" })
end

return M
