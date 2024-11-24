return {
  {
    "yetone/avante.nvim",
    keys = {
      { "<C-g>a", desc = "Avante Ask" },
      { "<C-g>e", desc = "Avante Edit" },
      { "<C-g>r", desc = "Avante Refresh" },
      { "<C-g>f", desc = "Avante Focus" },
    },
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { -- image pasting support
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_filename = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
    },
    opts = {
      provider = "claude",
      claude = {
        api_key_name = "cmd:op --account my read op://Private/Anthropic/credential",
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      mappings = {
        ask = "<C-g>a",
        edit = "<C-g>e",
        refresh = "<C-g>r",
        focus = "<C-g>f",
        toggle = {
          default = "<C-g>t",
          debug = "<C-g>d",
          hint = "<C-g>h",
          suggestion = "<C-g>s",
          repomap = "<C-g>R",
        },
      },
      windows = {
        position = "smart",
      },
    },
  },
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
}
