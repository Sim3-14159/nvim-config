vim.bo.comments = vim.bo.comments:gsub("s1:/%*", "s1:/**", 1)

local namespace = vim.api.nvim_create_namespace("c_open_comment")
local buffer = vim.api.nvim_get_current_buf()
local scheduled = false

local function find_open_comment()
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  local state, start_row, start_col = "code"

  for row, line in ipairs(lines) do
    local col = 1
    while col <= #line do
      local char = line:sub(col, col)
      local next_char = line:sub(col + 1, col + 1)

      if state == "block" then
        if char == "*" and next_char == "/" then
          state = "code"
          start_row = nil
          col = col + 2
        else
          col = col + 1
        end
      elseif state == "string" or state == "character" then
        if char == "\\" then
          col = col + 2
        elseif (state == "string" and char == '"') or (state == "character" and char == "'") then
          state = "code"
          col = col + 1
        else
          col = col + 1
        end
      elseif char == "/" and next_char == "/" then
        break
      elseif char == "/" and next_char == "*" then
        state = "block"
        start_row = row - 1
        start_col = col - 1
        col = col + 2
      elseif char == '"' then
        state = "string"
        col = col + 1
      elseif char == "'" then
        state = "character"
        col = col + 1
      else
        col = col + 1
      end
    end
    if state == "string" or state == "character" then
      state = "code"
    end
  end

  if state == "block" then
    return start_row, start_col, #lines - 1, #lines[#lines]
  end
end

local function update_highlight()
  scheduled = false
  if not vim.api.nvim_buf_is_valid(buffer) then
    return
  end

  vim.api.nvim_buf_clear_namespace(buffer, namespace, 0, -1)
  local start_row, start_col, end_row, end_col = find_open_comment()
  if start_row then
    vim.api.nvim_buf_set_extmark(buffer, namespace, start_row, start_col, {
      end_row = end_row,
      end_col = end_col,
      hl_group = "Comment",
      hl_eol = true,
      priority = 110,
    })
  end
end

local function schedule_highlight()
  if not scheduled then
    scheduled = true
    vim.schedule(update_highlight)
  end
end

vim.api.nvim_buf_attach(buffer, false, {
  on_lines = schedule_highlight,
})

update_highlight()
