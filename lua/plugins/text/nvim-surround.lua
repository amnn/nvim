require("lz.n").load {
  {
    "nvim-surround",
    event = "DeferredUIEnter",
    after = function() require("nvim-surround").setup {} end,
  },
}
