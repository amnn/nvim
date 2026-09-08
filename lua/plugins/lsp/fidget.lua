local p = require "config.packages"

local function setup()
  require("fidget").setup {
    notification = {
      window = {},
    },
  }
end

p.lazy { p.github("j-hui/fidget.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "fidget.nvim",
    event = "LspAttach",
    cmd = "Fidget",
    after = setup,
  },
}
