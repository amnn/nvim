local p = require "config.packages"

local function setup()
  require("crates").setup {
    completion = {
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
end

p.lazy { p.github("saecki/crates.nvim", "stable") }

require("lz.n").load {
  {
    "crates.nvim",
    event = "BufRead Cargo.toml",
    after = setup,
  },
}
