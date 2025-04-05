return {
  {
    "github/copilot.vim",
    version = "*",
    init = function() vim.g.copilot_no_tab_map = true end,
    lazy = false,
    keys = {
      {
        "<S-Tab>",
        mode = { "i", "n" },
        'copilot#Accept("\\<CR>")',
        expr = true,
        replace_keycodes = false,
        desc = "Accept suggestion (Copilot)",
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    keys = {
      {
        "<C-a>",
        [[<CMD>CodeCompanionActions<CR>]],
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Open the [A]ction Palette (CodeCompanion)",
      },
      {
        "<LocalLeader>a",
        [[<CMD>CodeCompanionChat Toggle<CR>]],
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "Toggle [A]I Chat (CodeCompanion)",
      },
      {
        "ga",
        [[<CMD>CodeCompanionChat Add<CR>]],
        mode = { "v" },
        noremap = true,
        silent = true,
        desc = "[A]dd selection to Chat (CodeCompanion)",
      },
    },
    init = function()
      vim.cmd [[cabbrev cc CodeCompanion]]
      require("plugins.ai.fidget"):init()
    end,
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "cmd:op --account my read op://Private/Anthropic/credential --no-newline",
            },
            schema = {
              model = {
                default = "claude-3-7-sonnet-20250219",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
