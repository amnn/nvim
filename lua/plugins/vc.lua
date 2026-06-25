vim.api.nvim_create_user_command(
  "Browse",
  function(opts) vim.fn.system { "open", opts.fargs[1] } end,
  { nargs = 1, desc = "Open URL in [Browse]r" }
)

return {
  {
    "tpope/vim-fugitive",
    version = "*",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    lazy = false,
    keys = {
      {
        "<leader>v",
        [[<CMD>tab G<CR>]],
        desc = "Open [v]ersion control (Fugitive)",
      },
      {
        "gB",
        [[<CMD>G blame<CR>]],
        desc = "Toggle [g]it [B]lame for file (Fugitive)",
      },
      {
        "gh",
        [[:0GBrowse<CR>]],
        desc = "Open on [G]it[H]ub (Fugitive)",
      },
      {
        "gh",
        mode = { "v" },
        [[:'<,'>GBrowse<CR>]],
        desc = "Open selection on [G]it[H]ub (Fugitive)",
      },
      {
        "gH",
        [[:0GBrowse!<CR>]],
        desc = "Copy [G]it[H]ub URL (Fugitive)",
      },
      {
        "gH",
        mode = { "v" },
        [[:'<,'>GBrowse!<CR>]],
        desc = "Copy [G]it[H]ub URL for selection (Fugitive)",
      },
    },
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
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
}
