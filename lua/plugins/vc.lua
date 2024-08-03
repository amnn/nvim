return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    cmds = { "G", "Git" },
    keys = {
      {
        "<leader>v",
        [[<CMD>G<CR>]],
        desc = "Open [v]ersion control",
      },
      {
        "gB",
        [[<CMD>G blame<CR>]],
        desc = "Toggle [g]it [B]lame for file",
      },
      {
        "gh",
        [[:0GBrowse<CR>]],
        desc = "Open on [G]it[H]ub",
      },
      {
        "gh",
        mode = { "v" },
        [[:'<,'>GBrowse<CR>]],
        desc = "Open selection on [G]it[H]ub",
      },
      {
        "gH",
        [[:0GBrowse!<CR>]],
        desc = "Copy [G]it[H]ub URL",
      },
      {
        "gH",
        mode = { "v" },
        [[:'<,'>GBrowse!<CR>]],
        desc = "Copy [G]it[H]ub URL for selection",
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
    lazy = false,
    keys = {
      {
        "gb",
        function() require("gitsigns").toggle_current_line_blame() end,
        desc = "Toggle [g]it [b]lame for current line",
      },
    },
  },
}
