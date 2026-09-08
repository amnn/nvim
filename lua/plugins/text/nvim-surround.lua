local p = require "config.packages"

local function setup() require("nvim-surround").setup {} end

p.eager { p.github("kylechui/nvim-surround", vim.version.range "*") }
setup()
