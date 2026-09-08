local p = require "config.packages"

local function setup() require("mason").setup {} end

p.lazy { p.github("williamboman/mason.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonLog",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
    after = setup,
  },
}
