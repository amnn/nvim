local p = require "config.packages"

local function setup()
  require("todo-comments").setup {
    highlight = {
      before = "",
      after = "",
      keyword = "fg",
      pattern = [[.*<(KEYWORDS)>]],
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]],
    },
  }
end

p.eager {
  p.github("folke/todo-comments.nvim", vim.version.range "*"),
  p.github "nvim-lua/plenary.nvim",
}
setup()
