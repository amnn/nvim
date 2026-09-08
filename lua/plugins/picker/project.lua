local p = require "config.packages"

local function setup()
  require("project_nvim").setup {
    detection_methods = { "pattern" },
    patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
  }
end

p.eager { p.github "ahmedkhalf/project.nvim" }
setup()
