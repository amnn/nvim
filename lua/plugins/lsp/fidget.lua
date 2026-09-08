local p = require "config.packages"

local function setup()
  require("fidget").setup {
    notification = {
      window = {},
    },
  }
end

p.eager { p.github("j-hui/fidget.nvim", vim.version.range "*") }
setup()
