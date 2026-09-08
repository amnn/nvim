local languages = require "config.treesitter"

require("lz.n").load {
  {
    "nvim-treesitter-context",
    ft = languages.context_filetypes,
    cmd = "TSContext",
    before = function() require("lz.n").trigger_load "nvim-treesitter" end,
    after = function()
      require("treesitter-context").setup {
        separator = "┄",
      }
    end,
  },
}
