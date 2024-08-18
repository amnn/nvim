return {
  { -- Color Scheme
    "miikanissi/modus-themes.nvim",
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
    dependencies = {
      -- Necessary to run the command to talk to kitty shell
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("dark_notify").run {
        onchange = function(mode)
          -- Notify Kitty that it should change its color scheme as well.
          local conf = mode == "dark" and "vivendi" or "operandi"
          require("plenary.job")
            :new({
              command = "kitty",
              args = {
                "@",
                "--to",
                "unix:/tmp/kitty-pipe",
                "set-colors",
                "--all",
                "--configured",
                "~/.config/kitty/modus-" .. conf .. ".conf",
              },
              enable_handlers = false,
            })
            :start()
        end,
      }
    end,
  },
}
