require("lz.n").load {
  {
    "flash.nvim",
    keys = {
      {
        "s",
        function() require("flash").jump() end,
        mode = { "n", "x" },
        desc = "Search (Flash)",
      },
      {
        "S",
        function() require("flash").treesitter() end,
        mode = { "n", "x", "o" },
        desc = "Search Treesitter (Flash)",
      },
      {
        "<C-s>",
        function() require("flash").toggle() end,
        mode = "c",
        desc = "Toggle Search (Flash)",
      },
    },
    after = function()
      require("flash").setup {
        keys = { "f", "F", "t", "T", [";"] = "\\", "," },
      }
    end,
  },
}
