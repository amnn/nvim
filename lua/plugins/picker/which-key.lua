require("lz.n").load {
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    cmd = "WhichKey",
    before = function() vim.cmd.packadd "nvim-web-devicons" end,
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer local Keymaps (Which Key)",
      },
    },
    after = function() require("which-key").setup {} end,
  },
}
