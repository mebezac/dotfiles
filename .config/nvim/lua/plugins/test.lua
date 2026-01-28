return {
  { "olimorris/neotest-rspec" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return {
              "docker",
              "compose",
              "run",
              "--rm",
              "app",
              "bin/rspec",
              "--tty",
            }
          end,

          transform_spec_path = function(path)
            local prefix = require("neotest-rspec").root(path)
            ---@diagnostic disable-next-line: param-type-mismatch
            return string.sub(path, string.len(prefix) + 2, -1)
          end,

          results_path = "tmp/rspec.output",
          formatter = "json",
        },
      },
    },
    keys = {
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to nearest (Neotest)",
      },
    },
  },
}
