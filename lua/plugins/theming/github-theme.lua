local p = require "config.packages"

local function setup()
  require("github-theme").setup {
    options = {
      transparent = true,
    },

    groups = {
      all = {
        TreesitterContext = { bg = "bg1" },
        ["@markup.raw"] = { style = "NONE" },
        BlinkCmpMenu = { link = "Normal" },
        BlinkCmpMenuBorder = { link = "FloatBorder" },
        BlinkCmpKind = { link = "Normal" },
        BlinkCmpLabelDeprecated = { link = "Normal" },
        BlinkCmpLabelDetail = { link = "Normal" },
        BlinkCmpLabelDescription = { link = "Normal" },
        BlinkCmpSource = { link = "Normal" },
        BlinkCmpScrollBarGutter = { link = "Normal" },
      },
    },
  }

  vim.cmd [[colorscheme github_light]]
end

p.eager { p.github("projekt0n/github-nvim-theme", nil, "github-theme") }
setup()
