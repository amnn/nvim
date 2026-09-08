local p = require "config.packages"

local function setup()
  require("dark_notify").run {
    schemes = {
      light = "github_light",
      dark = "github_dark",
    },
  }
end

p.eager { p.github("cormacrelf/dark-notify", vim.version.range "*") }
setup()
