local p = require "config.packages"

local function setup()
  require("mason-lspconfig").setup {
    automatic_enable = false,
  }
end

p.lazy { p.github("williamboman/mason-lspconfig.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    before = function() require("lz.n").trigger_load "mason.nvim" end,
    after = setup,
  },
}
