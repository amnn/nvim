return {
  {
    "Grazfather/sexp.nvim",
    dependencies = {
      "tpope/vim-repeat",
    },
    opts = {
      enable_insert_mode_mappings = false,
      insert_after_wrap = true,
      mappings = {
        sexp_round_head_wrap_element = "<LocalLeader>(",
        sexp_round_tail_wrap_element = "<LocalLeader>)",
        sexp_square_head_wrap_element = "<LocalLeader>[",
        sexp_square_tail_wrap_element = "<LocalLeader>]",
        sexp_curly_head_wrap_element = "<LocalLeader>{",
        sexp_curly_tail_wrap_element = "<LocalLeader>}",
        sexp_splice_list = "<LocalLeader>s",
        sexp_raise_element = "<LocalLeader>r",
        sexp_swap_element_backward = "<LocalLeader>T",
        sexp_swap_element_forward = "<LocalLeader>t",
        sexp_emit_head_element = "<LocalLeader>hb",
        sexp_emit_tail_element = "<LocalLeader>lb",
        sexp_capture_prev_element = "<LocalLeader>hs",
        sexp_capture_next_element = "<LocalLeader>ls",
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }
    end,
  },
  {
    "cappyzawa/trim.nvim",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      keys = { "f", "F", "t", "T", [";"] = "\\", "," },
    },
    keys = {
      {
        "s",
        mode = { "n", "x" },
        function() require("flash").jump() end,
        desc = "Flash",
      },

      {
        "S",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },

      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },
  {
    "gabrielpoca/replacer.nvim",
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "m4xshen/autoclose.nvim",
    opts = {
      keys = {
        ["'"] = { escape = true, close = false, pair = "''" },
        ["`"] = { escape = true, close = false, pair = "``" },
      },
      options = {
        pair_spaces = true,
        disabled_filetypes = { "gitcommit", "markdown", "text" },
      },
    },
  },
}
