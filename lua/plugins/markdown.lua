return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("render-markdown").setup {
      heading = {
        icons = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰎴 " },
      },
      code = {
        border = "thin",
        language_icon = false,
        language_name = false,
        left_pad = 2,
        right_pad = 2,
        inline_pad = 1,
        width = "block",
      },
    }
  end,
}
