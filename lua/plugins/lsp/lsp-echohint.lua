local p = require "config.packages"

local function setup() require("lsp-echohint").setup {} end

p.lazy { p.github "amnn/lsp-echohint.nvim" }

require("lz.n").load {
  {
    "lsp-echohint.nvim",
    event = "LspAttach",
    after = setup,
  },
}
