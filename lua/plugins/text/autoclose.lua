local p = require "config.packages"

local function setup()
  require("autoclose").setup {
    keys = {
      ["'"] = { escape = true, close = false, pair = "''" },
      ["`"] = { escape = true, close = false, pair = "``" },
    },
    options = {
      pair_spaces = true,
      disabled_filetypes = {
        "gitcommit",
        "markdown",
        "text",
        "typescript",
        "typescriptreact",
      },
    },
  }
end

p.lazy { p.github "m4xshen/autoclose.nvim" }

require("lz.n").load {
  {
    "autoclose.nvim",
    event = "InsertEnter",
    after = setup,
  },
}
