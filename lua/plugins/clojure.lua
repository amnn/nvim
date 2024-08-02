return {
  {
    "PaterJason/cmp-conjure",
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
    dependenceies = {
      "PaterJason/cmp-conjure",
    },
    ft = { "clojure" },
    lazy = true,
  },
  {
    "clojure-vim/vim-jack-in",
    dependenceies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
    commands = { "Clj", "Boot", "Lein" },
  },
}
