local github = require("config.packages").github

return {
  packages = {
    github(
      "sindrets/winshift.nvim",
      "37468ed6f385dfb50402368669766504c0e15583"
    ),
  },
  configure = function()
    require("winshift").setup {
      keymaps = {
        win_move_mode = {
          ["s"] = "swap",
        },
      },
    }

    vim.keymap.set(
      { "i", "n" },
      "<C-w><C-w>",
      [[<CMD>WinShift<CR>]],
      { desc = "WinShift Mode (WinShift)" }
    )
    vim.keymap.set(
      { "i", "n" },
      "<C-w>x",
      [[<CMD>WinShift swap<CR>]],
      { desc = "Swap windows (WinShift)" }
    )
  end,
}
