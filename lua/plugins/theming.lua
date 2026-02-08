return {
  { -- Color Scheme
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup {
        options = {
          transparent = true,
        },

        groups = {
          all = {
            TreesitterContext = { bg = "bg1" },
            ["@markup.raw"] = { style = "NONE" },
          },
        },
      }

      vim.cmd [[colorscheme github_light]]
    end,
  },
  { -- Status line
    "nvim-lualine/lualine.nvim",
    version = "*",
    opts = {
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
    },
  },
  { -- Automatically detect light and dark mode
    "cormacrelf/dark-notify",
    version = "*",
    config = function()
      local dn = require "dark_notify"
      dn.run {
        schemes = {
          light = "github_light",
          dark = "github_dark",
        },
      }
    end,
  },
}
