local p = require "config.packages"

local function setup()
  require("blink.cmp").setup {
    keymap = { preset = "default" },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
    signature = { enabled = true },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      sources = { "buffer", "cmdline" },
    },
  }
end

p.eager { p.github("saghen/blink.cmp", vim.version.range "1") }
setup()
