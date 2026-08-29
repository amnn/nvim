local github = require("config.packages").github

return {
  packages = {
    github(
      "projekt0n/github-nvim-theme",
      "c106c9472154d6b2c74b74565616b877ae8ed31d",
      "github-theme"
    ),
    github(
      "nvim-lualine/lualine.nvim",
      "221ce6b2d999187044529f49da6554a92f740a96"
    ),
    github(
      "cormacrelf/dark-notify",
      "46879bc7783e65ab6ed9607ef05fd9c1424786b6"
    ),
  },
  configure = function()
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

    require("lualine").setup {
      options = {
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str) return str:sub(1, 1) end,
          },
        },
      },
    }

    local dark_notify = require "dark_notify"
    dark_notify.run {
      schemes = {
        light = "github_light",
        dark = "github_dark",
      },
    }
  end,
}
