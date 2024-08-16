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
        [[<CMD>tab G<CR>]],
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
    init = function()
      vim.api.nvim_create_user_command(
        "GHunk",
        function() require("gitsigns").preview_hunk() end,
        { desc = "Preview [Hunk] (GitSigns)" }
      )
    end,
    keys = {
      {
        "[H",
        function() require("gitsigns").nav_hunk "first" end,
        desc = "Navigate to first [H]unk (GitSigns)",
      },
      {
        "]H",
        function() require("gitsigns").nav_hunk "last" end,
        desc = "Navigate to last [H]unk (GitSigns)",
      },
      {
        "[h",
        function() require("gitsigns").nav_hunk "prev" end,
        desc = "Navigate to previous [h]unk (GitSigns)",
      },
      {
        "]h",
        function() require("gitsigns").nav_hunk "next" end,
        desc = "Navigate to next [h]unk (GitSigns)",
      },
      {
        "gb",
        function() require("gitsigns").toggle_current_line_blame() end,
        desc = "Toggle [g]it [b]lame for current line (GitSigns)",
      },
    },
  },
  {
    "rbong/vim-flog",
    dependencies = {
      "tpope/vim-fugitive",
    },
    cmd = { "Flog", "Flogsplit", "Floggit" },
  },
}
