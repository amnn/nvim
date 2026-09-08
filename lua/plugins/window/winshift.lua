local p = require "config.packages"

local function setup()
  require("winshift").setup {
    keymaps = {
      win_move_mode = {
        ["s"] = "swap",
      },
    },
  }
end

p.lazy { p.github "sindrets/winshift.nvim" }

require("lz.n").load {
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
    after = setup,
  },
}
