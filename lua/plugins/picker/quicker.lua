local p = require "config.packages"

local function setup()
  require("quicker").setup {
    keys = {
      {
        ">",
        function()
          require("quicker").expand {
            before = 2,
            after = 2,
            add_to_existing = true,
          }
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function() require("quicker").collapse() end,
        desc = "Collapse quickfix context",
      },
    },
  }
end

p.lazy { p.github("stevearc/quicker.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "quicker.nvim",
    ft = "qf",
    after = setup,
  },
}
