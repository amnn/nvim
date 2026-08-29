local github = require("config.packages").github

return {
  packages = {
    github("Grazfather/sexp.nvim", "2a7c48d602dcb3fb39978c5ad8f1890cb4e95940"),
    github("tpope/vim-repeat", "65846025c15494983dafe5e3b46c8f88ab2e9635"),
    github(
      "HiPhish/rainbow-delimiters.nvim",
      "b81d594e82b6ca1530797bdcfd16a1219250a2d8"
    ),
    github("cappyzawa/trim.nvim", "765360a6f6ac732f4c78c5c694f4b892a55b53ec"),
    github("folke/flash.nvim", "ec0bf2842189f65f60fd40bf3557cac1029cc932"),
    github(
      "folke/todo-comments.nvim",
      "31e3c38ce9b29781e4422fc0322eb0a21f4e8668"
    ),
    github("nvim-lua/plenary.nvim", "74b06c6c75e4eeb3108ec01852001636d85a932b"),
    github(
      "kylechui/nvim-surround",
      "2e93e154de9ff326def6480a4358bfc149d5da2c"
    ),
    github(
      "m4xshen/autoclose.nvim",
      "27063904b2238ce7867e430885b6abcfb08357ea"
    ),
  },
  configure = function()
    require("sexp").setup {
      enable_insert_mode_mappings = false,
      insert_after_wrap = true,
      mappings = {
        sexp_round_head_wrap_element = "<LocalLeader>(",
        sexp_round_tail_wrap_element = "<LocalLeader>)",
        sexp_square_head_wrap_element = "<LocalLeader>[",
        sexp_square_tail_wrap_element = "<LocalLeader>]",
        sexp_curly_head_wrap_element = "<LocalLeader>{",
        sexp_curly_tail_wrap_element = "<LocalLeader>}",
        sexp_splice_list = "<LocalLeader>S",
        sexp_raise_element = "<LocalLeader>R",
        sexp_swap_element_backward = "<LocalLeader>T",
        sexp_swap_element_forward = "<LocalLeader>t",
        sexp_emit_head_element = "<LocalLeader>hb",
        sexp_emit_tail_element = "<LocalLeader>lb",
        sexp_capture_prev_element = "<LocalLeader>hs",
        sexp_capture_next_element = "<LocalLeader>ls",
      },
    }

    local rainbow_delimiters = require "rainbow-delimiters"
    require("rainbow-delimiters.setup").setup {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
      },
    }

    require("trim").setup {}

    require("flash").setup {
      keys = { "f", "F", "t", "T", [";"] = "\\", "," },
    }
    vim.keymap.set(
      { "n", "x" },
      "s",
      function() require("flash").jump() end,
      { desc = "Search (Flash)" }
    )
    vim.keymap.set(
      { "n", "x", "o" },
      "S",
      function() require("flash").treesitter() end,
      { desc = "Search Treesitter (Flash)" }
    )
    vim.keymap.set(
      "c",
      "<C-s>",
      function() require("flash").toggle() end,
      { desc = "Toggle Search (Flash)" }
    )

    require("todo-comments").setup {
      highlight = {
        before = "",
        after = "",
        keyword = "fg",
        pattern = [[.*<(KEYWORDS)>]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    }

    require("nvim-surround").setup {}

    require("autoclose").setup {
      keys = {
        ["'"] = { escape = true, close = false, pair = "''" },
        ["`"] = { escape = true, close = false, pair = "``" },
      },
      options = {
        pair_spaces = true,
        disabled_filetypes = {
          "gitcommit",
          "markdown",
          "text",
          "typescript",
          "typescriptreact",
        },
      },
    }
  end,
}
