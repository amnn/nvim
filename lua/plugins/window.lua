return {
  {
    "sindrets/winshift.nvim",
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
      },
      {
        "<C-w>x",
        mode = { "i", "n" },
        [[<CMD>WinShift swap<CR>]],
      },
    },
  },
}
