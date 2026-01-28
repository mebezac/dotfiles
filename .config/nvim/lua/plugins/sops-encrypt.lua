return {
  -- This creates a "plugin" that's just keymaps
  dir = vim.fn.stdpath("config"),
  name = "sops-integration",
  config = function()
    local function sops_encrypt()
      local file_path = vim.fn.expand("%:p")

      if file_path == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
      end

      -- Save file if modified
      if vim.bo.modified then
        vim.cmd("write")
      end

      -- Show progress
      vim.notify("🔄 Encrypting with SOPS...", vim.log.levels.INFO)

      vim.system({ "sops", "encrypt", "-i", file_path }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            vim.notify("🔒 File encrypted successfully", vim.log.levels.INFO)
            vim.cmd("edit!") -- Reload to show encrypted content
          else
            vim.notify("❌ SOPS error: " .. (result.stderr or "Unknown error"), vim.log.levels.ERROR)
          end
        end)
      end)
    end

    vim.keymap.set("n", "<leader>se", sops_encrypt, { desc = "SOPS encrypt current file" })
  end,
}
