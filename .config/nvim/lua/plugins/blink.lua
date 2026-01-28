return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      completion = {
        keyword = {
          range = "full",
        },
      },
      keymap = {
        preset = "super-tab",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
          require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
          "fallback",
        },
      },
      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "copilot", "lsp", "snippets", "path", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            kind = "Copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
