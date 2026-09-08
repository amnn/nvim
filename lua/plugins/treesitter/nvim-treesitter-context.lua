local p = require "config.packages"

local function setup()
  require("treesitter-context").setup {
    separator = "┄",
  }
end

p.eager { p.github "nvim-treesitter/nvim-treesitter-context" }
setup()
