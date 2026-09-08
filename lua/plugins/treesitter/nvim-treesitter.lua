local languages = require "config.treesitter"

require("lz.n").load {
  {
    "nvim-treesitter",
    event = {
      "DeferredUIEnter",
      { event = "FileType", pattern = languages.filetypes },
    },
    cmd = {
      "TSInstall",
      "TSInstallFromGrammar",
      "TSLog",
      "TSUninstall",
      "TSUpdate",
    },
    after = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          local parsers = require "nvim-treesitter.parsers"
          for parser, config in pairs(languages.parser_configs) do
            parsers[parser] = config
          end
        end,
      })

      local treesitter = require "nvim-treesitter"
      treesitter.setup()
      treesitter.install(languages.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages.filetypes,
        callback = function(event) pcall(vim.treesitter.start, event.buf) end,
      })
    end,
  },
}
