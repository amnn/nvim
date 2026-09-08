local p = require "config.packages"

local function setup()
  require("flash").setup {
    keys = { "f", "F", "t", "T", [";"] = "\\", "," },
  }

  vim.keymap.set(
    { "n", "x" },
    "s",
    function() require("flash").jump() end,
    { desc = "Search (Flash)" }
  )

  vim.keymap.set(
    { "n", "x", "o" },
    "S",
    function() require("flash").treesitter() end,
    { desc = "Search Treesitter (Flash)" }
  )

  vim.keymap.set(
    "c",
    "<C-s>",
    function() require("flash").toggle() end,
    { desc = "Toggle Search (Flash)" }
  )
end

p.eager { p.github("folke/flash.nvim", vim.version.range "*") }
setup()
