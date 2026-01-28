return {
  "mfussenegger/nvim-ansible",
  keys = {
    { "<leader>ta", false },
    {
      "<leader>tA",
      function()
        require("ansible").run()
      end,
      desc = "Ansible Run Playbook/Role",
      silent = true,
    },
  },
}
