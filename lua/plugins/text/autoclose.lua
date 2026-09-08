require("lz.n").load {
  {
    "autoclose.nvim",
    event = "InsertEnter",
    after = function()
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
  },
}
