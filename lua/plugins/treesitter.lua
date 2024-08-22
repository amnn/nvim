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
