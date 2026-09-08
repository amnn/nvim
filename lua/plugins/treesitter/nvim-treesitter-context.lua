local filetypes = {
  "c",
  "clojure",
  "fennel",
  "fish",
  "graphql",
  "go",
  "gomod",
  "gowork",
  "lua",
  "markdown",
  "markdown_inline",
  "move",
  "python",
  "rust",
  "scheme",
  "sql",
  "tsx",
  "typescript",
  "typst",
  "vim",
}

require("lz.n").load {
  {
    "nvim-treesitter-context",
    ft = filetypes,
    cmd = "TSContext",
    before = function() require("lz.n").trigger_load "nvim-treesitter" end,
    after = function()
      require("treesitter-context").setup {
        separator = "┄",
      }
    end,
  },
}
