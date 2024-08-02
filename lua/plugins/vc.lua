return {
  {
    "FabijanZulj/blame.nvim",
    cmds = { "BlameToggle" },
    keys = {
      {
        "gB",
        function() vim.cmd [[BlameToggle]] end,
        desc = "Toggle [g]it [B]lame for file",
      },
    },
    config = function()
      require("blame").setup {
        date_format = "%Y-%m-%d",
        virtual_style = "float",
        max_summary_width = 40,
        format_fn = require("blame.formats.default_formats").date_message,
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      signs = {
        hunk = { "▶", "▼" },
        item = { "▶", "▼" },
        section = { "▶", "▼" },
      },
    },
    keys = {
      {
        "<leader>v",
        function() require("neogit").open() end,
        desc = "Open [v]ersion control",
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
  {
    "ruifm/gitlinker.nvim",
    opts = {
      mappings = nil,
    },
    keys = {
      {
        "gh",
        mode = "n",
        function()
          require("gitlinker").get_buf_range_url("n", {
            action_callback = require("gitlinker.actions").open_in_browser,
          })
        end,
        desc = "Open on [G]it[H]ub",
      },
      {
        "gh",
        mode = "v",
        function()
          require("gitlinker").get_buf_range_url("v", {
            action_callback = require("gitlinker.actions").open_in_browser,
          })
        end,
        desc = "Open on [G]it[H]ub",
      },
      {
        "gH",
        mode = "n",
        function()
          require("gitlinker").get_buf_range_url("n", {
            action_callback = require("gitlinker.actions").copy_to_clipboard,
          })
        end,
        desc = "Copy [G]it[H]ub URL",
      },
      {
        "gH",
        mode = "v",
        function()
          require("gitlinker").get_buf_range_url("v", {
            action_callback = require("gitlinker.actions").copy_to_clipboard,
          })
        end,
        desc = "Copy [G]it[H]ub URL",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      view = {
        merge_tool = {
          layout = "diff4_mixed",
        },
      },
    },
  },
}
