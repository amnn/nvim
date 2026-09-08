require("lz.n").load {
  {
    "crates.nvim",
    event = "BufRead Cargo.toml",
    after = function()
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
    end,
  },
}
