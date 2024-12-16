return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "c",
          "clojure",
          "fennel",
          "fish",
          "graphql",
          "go",
          "gomod",
          "gowork",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "rust",
          "scheme",
          "sql",
          "tsx",
          "typescript",
          "vim",
        },

        modules = {},
        ignore_install = {},
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          disable = { "gitcommit" },
        },
      }

      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      parsers["move"] = {
        filetype = "move",
        maintainers = {},
        install_info = {
          url = "~/tree-sitter-move",
          branch = "main",
          files = { "src/parser.c" },
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    version = "*",
    opts = {
      separator = "┄",
    },
  },
}
