local p = require "config.packages"

local function setup() require("trim").setup {} end

p.eager { p.github("cappyzawa/trim.nvim", vim.version.range "*") }
setup()
