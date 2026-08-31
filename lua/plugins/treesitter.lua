local eager = require("config.packages").eager
local github = require("config.packages").github

eager {
  github("nvim-treesitter/nvim-treesitter", "main"),
  github "nvim-treesitter/nvim-treesitter-context",
}

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
        url = "https://github.com/mystenlabs/sui",
        revision = "main",
        path = "~/Code/tree-sitter-move/external-crates/move/tooling/tree-sitter",
      },
      tier = 2,
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
