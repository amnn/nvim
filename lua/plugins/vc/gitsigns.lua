require("lz.n").load {
  {
    "gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "GHunk", "Gitsigns" },
    after = function()
      vim.api.nvim_create_user_command(
        "GHunk",
        function() require("gitsigns").preview_hunk() end,
        { desc = "Preview [Hunk] (GitSigns)" }
      )

      require("gitsigns").setup {}

      vim.keymap.set(
        "n",
        "[H",
        function() require("gitsigns").nav_hunk "first" end,
        { desc = "Navigate to first [H]unk (GitSigns)" }
      )

      vim.keymap.set(
        "n",
        "]H",
        function() require("gitsigns").nav_hunk "last" end,
        { desc = "Navigate to last [H]unk (GitSigns)" }
      )

      vim.keymap.set(
        "n",
        "[h",
        function() require("gitsigns").nav_hunk "prev" end,
        { desc = "Navigate to previous [h]unk (GitSigns)" }
      )

      vim.keymap.set(
        "n",
        "]h",
        function() require("gitsigns").nav_hunk "next" end,
        { desc = "Navigate to next [h]unk (GitSigns)" }
      )

      vim.keymap.set(
        "n",
        "gb",
        function() require("gitsigns").toggle_current_line_blame() end,
        { desc = "Toggle [g]it [b]lame for current line (GitSigns)" }
      )
    end,
  },
}
