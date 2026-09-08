local p = require "config.packages"

local function setup()
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
end

p.eager {
  p.github "nvim-lualine/lualine.nvim",
  p.github "nvim-tree/nvim-web-devicons",
}
setup()
