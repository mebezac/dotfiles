-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ruby: expand "#" to "#{ }" inside double-quoted strings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function(args)
    local bufnr = args.buf

    local function in_double_quoted_string_linewise()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local col = vim.fn.col(".") -- 1-based
      local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""

      local before = line:sub(1, math.max(col - 1, 0))
      local after = line:sub(col)

      -- Check we’re between two double quotes somewhere on this line
      local has_before_quote = before:find('"', 1, true) ~= nil
      local has_after_quote = after:find('"', 1, true) ~= nil
      return has_before_quote and has_after_quote
    end

    -- Buffer-local insert expr mapping for "#"
    vim.keymap.set("i", "#", function()
      if in_double_quoted_string_linewise() then
        return "#{}<left>"
      end
      return "#"
    end, {
      expr = true,
      silent = true,
      buffer = bufnr,
      desc = "Ruby interpolation #{...} when inside double quotes",
    })

    if vim.g.loadedsurround then
      vim.b.surround_35 = "#{\r}"
    end
  end,
})
