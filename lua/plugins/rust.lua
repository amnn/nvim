local github = require("config.packages").github

return {
  packages = {
    github("saecki/crates.nvim", "afcd1cc3eeceb5783676fc8464389b9216a29d05"),
  },
  configure = function()
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
}
