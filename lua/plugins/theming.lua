local github = require("config.packages").github

return {
  packages = {
    github("projekt0n/github-nvim-theme", nil, "github-theme"),
    github "nvim-lualine/lualine.nvim",
    github("cormacrelf/dark-notify", vim.version.range "*"),
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
