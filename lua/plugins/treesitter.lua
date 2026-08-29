local github = require("config.packages").github

return {
  packages = {
    github(
      "nvim-treesitter/nvim-treesitter",
      "857651fce37eba032ebe28f3a206283cdc65c45a"
    ),
    github(
      "nvim-treesitter/nvim-treesitter-context",
      "f3061339b8eaf9fda873600bc425b8d2d8502533"
    ),
  },
  configure = function()
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

    require("treesitter-context").setup {
      separator = "┄",
    }
  end,
}
