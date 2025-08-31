-- ~/todo.md scratchpad helpers

local map = vim.keymap.set

-- Toggle markdown checkbox under cursor [ ] <-> [x]
local function toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*%- %[ %]") then
    line = line:gsub("%[ %]", "[x]")
  elseif line:match("^%s*%- %[x%]") then
    line = line:gsub("%[x%]", "[ ]")
  end
  vim.api.nvim_set_current_line(line)
end

-- Insert a new checkbox below current line
local function new_checkbox()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, true, { "- [ ] " })
  vim.api.nvim_win_set_cursor(0, { row + 1, 6 }) -- place cursor after checkbox
end

-- Jump to next checkbox
local function next_checkbox()
  vim.cmd("/- \\[.\\]")
end

-- Jump to previous checkbox
local function prev_checkbox()
  vim.cmd("?\\- \\[.\\]")
end

-- Keymaps (only active in markdown / todo.md)
map("n", "<leader>t", toggle_checkbox, { desc = "Toggle checkbox" })
map("n", "<leader>n", new_checkbox, { desc = "Insert new checkbox" })
map("n", "<leader>j", next_checkbox, { desc = "Next checkbox" })
map("n", "<leader>k", prev_checkbox, { desc = "Previous checkbox" })
