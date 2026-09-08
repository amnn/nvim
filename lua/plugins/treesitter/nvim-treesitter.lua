local p = require "config.packages"

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

local function setup()
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

  local treesitter = require "nvim-treesitter"
  treesitter.setup()
  treesitter.install(ensure_installed)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = ensure_installed,
    callback = function(event) pcall(vim.treesitter.start, event.buf) end,
  })
end

p.lazy { p.github("nvim-treesitter/nvim-treesitter", "main") }

require("lz.n").load {
  {
    "nvim-treesitter",
    event = {
      "DeferredUIEnter",
      { event = "FileType", pattern = ensure_installed },
    },
    cmd = {
      "TSInstall",
      "TSInstallFromGrammar",
      "TSLog",
      "TSUninstall",
      "TSUpdate",
    },
    after = setup,
  },
}
