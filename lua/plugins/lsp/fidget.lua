require("lz.n").load {
  {
    "fidget.nvim",
    event = "LspAttach",
    cmd = "Fidget",
    after = function()
      require("fidget").setup {
        notification = {
          window = {},
        },
      }
    end,
  },
}
