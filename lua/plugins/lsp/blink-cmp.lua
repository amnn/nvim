require("lz.n").load {
  {
    "blink.cmp",
    event = { "CmdlineEnter", "InsertEnter" },
    cmd = "BlinkCmp",
    after = function()
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
    end,
  },
}
