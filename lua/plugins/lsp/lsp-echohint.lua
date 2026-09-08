local p = require "config.packages"

local function setup() require("lsp-echohint").setup {} end

p.eager { p.github "amnn/lsp-echohint.nvim" }
setup()
