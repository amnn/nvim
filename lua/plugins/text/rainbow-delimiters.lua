local p = require "config.packages"

local function setup()
  local rainbow_delimiters = require "rainbow-delimiters"
  require("rainbow-delimiters.setup").setup {
    strategy = {
      [""] = rainbow_delimiters.strategy["global"],
    },
    query = {
      [""] = "rainbow-delimiters",
    },
  }
end

p.lazy { p.github("HiPhish/rainbow-delimiters.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "rainbow-delimiters.nvim",
    event = "FileType",
    after = setup,
  },
}
