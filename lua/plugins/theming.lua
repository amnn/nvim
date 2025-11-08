return {
  { -- Color Scheme
    "miikanissi/modus-themes.nvim",
    version = "*",
    priority = 1000,
    config = function()
      require("modus-themes").setup {
        on_highlights = function(highlights, colors)
          highlights.ColorColumn.bg = "NONE"
          highlights.SignColumn.bg = "NONE"
          highlights.LineNr.bg = "NONE"
          highlights.LineNrAbove.bg = "NONE"
          highlights.LineNrBelow.bg = "NONE"
          highlights.NormalFloat = { bg = colors.bg_main }
          highlights.WinSeparator = { bg = "NONE" }
          highlights.TreesitterContext = { bg = "NONE" }
        end,
      }

      vim.o.fillchars = "vert: "
      vim.opt.colorcolumn = vim.fn.range(80, 100)

      vim.cmd [[colorscheme modus]]
    end,
  },
  { -- Status line
    "nvim-lualine/lualine.nvim",
    version = "*",
    init = function() vim.g.ayuprefermirage = true end,
    opts = {
      options = {
        theme = "ayu",
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
    config = function() require("dark_notify").run {} end,
  },
}
