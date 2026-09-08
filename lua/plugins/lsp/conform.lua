local p = require "config.packages"

local function setup()
  require("conform").setup {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      clojure = { "cljfmt" },
      go = { "gofmt" },
      javascript = { "prettier" },
      lua = { "stylua" },
      move = { "prettier-move" },
      python = { "black" },
      rust = { "rustfmt" },
      swift = { "swift" },
      typescript = { "prettier" },
      typst = { "typstyle" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      cljfmt = {
        command = "cljfmt",
        args = { "fix", "$FILENAME" },
        stdin = false,
      },
      ["prettier-move"] = {
        command = "prettier-move",
        args = { "--stdin-filepath", "$FILENAME" },
        range_args = function(_, ctx)
          local util = require "conform.util"
          local lo, hi = util.get_offsets_from_range(ctx.buf, ctx.range)
          return {
            "--stdin-filepath",
            "$FILENAME",
            "--range-start=" .. lo,
            "--range-end=" .. hi,
          }
        end,
      },
    },
  }
end

p.lazy { p.github("stevearc/conform.nvim", vim.version.range "*") }

require("lz.n").load {
  {
    "conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    after = setup,
  },
}
