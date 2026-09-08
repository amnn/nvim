local p = require "config.packages"

local function setup() require("trim").setup {} end

p.lazy { p.github("cappyzawa/trim.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "trim.nvim",
    event = "BufWritePre",
    cmd = { "Trim", "TrimToggle" },
    after = setup,
  },
}
