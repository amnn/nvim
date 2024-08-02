return {
  { -- Color Scheme
    "Shatur/neovim-ayu",
    config = function()
      local ayu = require "ayu"
      local colors = require "ayu.colors"
      colors.generate(false)

      local function background()
        if vim.o.background == "dark" then
          return "#0e1419"
        else
          return "#fafafa"
        end
      end

      ayu.setup {
        terminal = false,
        overrides = function()
          return {
            ColorColumn = { bg = colors.guide_normal },
            Normal = { bg = background() },
            SignColumn = { bg = "None" },
            WinSeparator = { bg = "None" },
            TreesitterContext = { bg = "None" },
          }
        end,
      }

      ayu.colorscheme()
      vim.o.fillchars = "vert: "
      vim.opt.colorcolumn = vim.fn.range(80, 120)
    end,
  },
  { -- Status line
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "Shatur/neovim-ayu",
    },
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
                "~/.config/kitty/ayu-" .. mode .. ".conf",
              },
              enable_handlers = false,
            })
            :start()
        end,
      }
    end,
  },
}
