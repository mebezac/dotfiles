-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>fy", "<cmd>:let @* = expand('%:~:.')<cr>", { desc = "Copy relative path of current buffer" })
map("n", "<leader>fY", "<cmd>:let @* = expand('%:p')<cr>", { desc = "Copy path of current buffer" })
map("n", "<leader>*", "*Ncgn", { desc = "Change word under cursor and next occurrences" })
map("n", "<leader>sx", function()
  Snacks.picker.grep({ glob = "!*spec*" })
end, { desc = "Grep (Without tests)" })
