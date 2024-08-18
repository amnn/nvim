return {
  {
    "sindrets/winshift.nvim",
    version = "*",
    opts = {
      keymaps = {
        win_move_mode = {
          ["s"] = "swap",
        },
      },
    },
    keys = {
      {
        "<C-w><C-w>",
        mode = { "i", "n" },
        [[<CMD>WinShift<CR>]],
        desc = "WinShift Mode (WinShift)",
      },
      {
        "<C-w>x",
        mode = { "i", "n" },
        [[<CMD>WinShift swap<CR>]],
        desc = "Swap windows (WinShift)",
      },
    },
  },
}
