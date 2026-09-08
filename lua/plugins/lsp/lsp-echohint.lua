require("lz.n").load {
  {
    "lsp-echohint.nvim",
    event = "LspAttach",
    after = function() require("lsp-echohint").setup {} end,
  },
}
