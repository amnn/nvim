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

p.eager { p.github "m4xshen/autoclose.nvim" }
setup()
