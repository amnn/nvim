local p = require "config.packages"

local function setup()
  require("flash").setup {
    keys = { "f", "F", "t", "T", [";"] = "\\", "," },
  }
end

p.lazy { p.github("folke/flash.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "flash.nvim",
    keys = {
      {
        "s",
        function() require("flash").jump() end,
        mode = { "n", "x" },
        desc = "Search (Flash)",
      },
      {
        "S",
        function() require("flash").treesitter() end,
        mode = { "n", "x", "o" },
        desc = "Search Treesitter (Flash)",
      },
      {
        "<C-s>",
        function() require("flash").toggle() end,
        mode = "c",
        desc = "Toggle Search (Flash)",
      },
    },
    after = setup,
  },
}
