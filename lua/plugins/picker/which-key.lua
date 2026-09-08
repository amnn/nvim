local p = require "config.packages"

local function setup() require("which-key").setup {} end

p.lazy {
  p.github("folke/which-key.nvim", vim.version.range "*"),
  p.github "nvim-tree/nvim-web-devicons",
}

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
    after = setup,
  },
}
