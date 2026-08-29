local github = require("config.packages").github

return {
  packages = {
    github("tpope/vim-fugitive", "96c1009fcf8ce60161cc938d149dd5a66d570756"),
    github("tpope/vim-rhubarb", "5496d7c94581c4c9ad7430357449bb57fc59f501"),
    github(
      "julienvincent/hunk.nvim",
      "c8a8e7b6973576f63e5bf39aa8338d7f37f4dc53"
    ),
    github("MunifTanjim/nui.nvim", "10fc361835c856ba4233ef5ea135b919bf3dce97"),
    github(
      "lewis6991/gitsigns.nvim",
      "5be654f2232c10ddcad19c1607a67b6b4b78fc29"
    ),
  },
  configure = function()
    vim.api.nvim_create_user_command(
      "Browse",
      function(opts) vim.fn.system { "open", opts.fargs[1] } end,
      { nargs = 1, desc = "Open URL in [Browse]r" }
    )

    vim.keymap.set("n", "<leader>v", [[<CMD>tab G<CR>]], {
      desc = "Open [v]ersion control (Fugitive)",
    })
    vim.keymap.set("n", "gB", [[<CMD>G blame<CR>]], {
      desc = "Toggle [g]it [B]lame for file (Fugitive)",
    })
    vim.keymap.set("n", "gh", [[:0GBrowse<CR>]], {
      desc = "Open on [G]it[H]ub (Fugitive)",
    })
    vim.keymap.set("v", "gh", [[:'<,'>GBrowse<CR>]], {
      desc = "Open selection on [G]it[H]ub (Fugitive)",
    })
    vim.keymap.set("n", "gH", [[:0GBrowse!<CR>]], {
      desc = "Copy [G]it[H]ub URL (Fugitive)",
    })
    vim.keymap.set("v", "gH", [[:'<,'>GBrowse!<CR>]], {
      desc = "Copy [G]it[H]ub URL for selection (Fugitive)",
    })

    require("hunk").setup {
      hooks = {
        on_tree_mount = function(context)
          vim.api.nvim_set_option_value(
            "wrap",
            false,
            { win = context.opts.winid }
          )
        end,
      },
    }

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
}
