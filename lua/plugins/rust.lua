return {
  {
    "saecki/crates.nvim",
    tag = "stable",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
          crates = {
            enabled = true,
            max_results = 8,
            min_chars = 3,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }

      local cmp = require "cmp"
      local cfg = cmp.get_config()
      table.insert(cfg, { name = "crates" })
      cmp.setup(cfg)
    end,
  },
}
