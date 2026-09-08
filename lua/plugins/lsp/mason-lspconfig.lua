local p = require "config.packages"

local function setup()
  require("mason-lspconfig").setup {
    automatic_enable = false,
  }
end

p.eager { p.github("williamboman/mason-lspconfig.nvim", vim.version.range "*") }
setup()
