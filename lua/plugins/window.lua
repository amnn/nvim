local github = require("config.packages").github

return {
  packages = {
    github "sindrets/winshift.nvim",
  },
  lazy = {
    {
      "winshift.nvim",
      cmd = "WinShift",
      keys = {
        {
          "<C-w><C-w>",
          [[<CMD>WinShift<CR>]],
          mode = { "i", "n" },
          desc = "WinShift Mode (WinShift)",
        },
        {
          "<C-w>x",
          [[<CMD>WinShift swap<CR>]],
          mode = { "i", "n" },
          desc = "Swap windows (WinShift)",
        },
      },
      after = function()
        require("winshift").setup {
          keymaps = {
            win_move_mode = {
              ["s"] = "swap",
            },
          },
        }
      end,
    },
  },
}
