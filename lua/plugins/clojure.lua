return {
  {
    "PaterJason/cmp-conjure",
    version = "*",
    lazy = true,
    config = function()
      local cmp = require "cmp"
      local cfg = cmp.get_config()
      table.insert(cfg, { name = "conjure" })
      return cmp.setup(cfg)
    end,
  },
  {
    "Olical/conjure",
    version = "*",
    dependenceies = {
      "PaterJason/cmp-conjure",
    },
    ft = { "clojure" },
    lazy = true,
    init = function()
      vim.g["conjure#filetypes"] = {
        "clojure",
        "fennel",
        "janet",
        "hy",
        "racket",
        "scheme",
        "lisp",
        "sql",
      }
    end,
  },
  {
    "clojure-vim/vim-jack-in",
    version = "*",
    dependenceies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
    commands = { "Clj", "Boot", "Lein" },
  },
}
