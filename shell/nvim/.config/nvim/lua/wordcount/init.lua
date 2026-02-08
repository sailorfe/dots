local M = {}

local function strip_yaml_frontmatter(lines)
  if #lines < 2 or lines[1] ~= "---" then
    return lines
  end
  for i = 2, #lines do
    if lines[i] == "---" then
      return vim.list_slice(lines, i + 1)
    end
  end
  return lines
end

local function get_buf_text()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.bo.filetype == "markdown" then
    lines = strip_yaml_frontmatter(lines)
  end
  return lines
end

function M.count()
  local lines = get_buf_text()
  local input = table.concat(lines, "\n")
  
  vim.system({"wc"}, {
    stdin = input,
    text = true,
  }, function(result)
    vim.schedule(function()
      if result.code == 0 then
        local l, w, b = result.stdout:match("(%d+)%s+(%d+)%s+(%d+)")
        if l and w and b then
          if vim.bo.filetype == "markdown" then
            print(string.format("%s words", w))
          else
            print(string.format("%s lines, %s words, %s bytes", l, w, b))
          end
        end
      end
    end)
  end)
end

return M
