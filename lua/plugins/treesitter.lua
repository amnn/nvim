return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require "nvim-treesitter"
      local ensure_installed = {
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
        "move",
        "python",
        "rust",
        "scheme",
        "sql",
        "tsx",
        "typescript",
        "typst",
        "vim",
      }

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").move = {
            install_info = {
              path = "~/Code/tree-sitter-move/external-crates/move/tooling/tree-sitter",
            },
          }
        end,
      })

      treesitter.setup()
      treesitter.install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = ensure_installed,
        callback = function(event) pcall(vim.treesitter.start, event.buf) end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      separator = "┄",
    },
  },
}
