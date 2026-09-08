require("lz.n").load {
  {
    "trim.nvim",
    event = "BufWritePre",
    cmd = { "Trim", "TrimToggle" },
    after = function() require("trim").setup {} end,
  },
}
