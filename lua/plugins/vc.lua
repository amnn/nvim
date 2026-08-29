local github = require("config.packages").github

return {
  packages = {
    github "tpope/vim-fugitive",
    github "tpope/vim-rhubarb",
    github "julienvincent/hunk.nvim",
    github "MunifTanjim/nui.nvim",
    github "lewis6991/gitsigns.nvim",
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
  lazy = {
    {
      "hunk.nvim",
      cmd = "DiffEditor",
      after = function()
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
      end,
    },
  },
}
