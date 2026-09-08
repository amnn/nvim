local p = require "config.packages"

local function setup()
  require("project_nvim").setup {
    detection_methods = { "pattern" },
    patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
  }
  require("project_nvim.project").on_buf_enter()
end

p.lazy { p.github "ahmedkhalf/project.nvim" }

require("lz.n").load {
  {
    "project.nvim",
    event = "DeferredUIEnter",
    cmd = { "AddProject", "ProjectRoot" },
    after = setup,
  },
}
