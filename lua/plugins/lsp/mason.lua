local p = require "config.packages"

local function setup() require("mason").setup {} end

p.eager { p.github("williamboman/mason.nvim", vim.version.range "*") }
setup()
