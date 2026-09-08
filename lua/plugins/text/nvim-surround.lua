local p = require "config.packages"

local function setup() require("nvim-surround").setup {} end

p.lazy { p.github("kylechui/nvim-surround", vim.version.range "*") }

require("lz.n").load {
  {
    "nvim-surround",
    event = "DeferredUIEnter",
    after = setup,
  },
}
