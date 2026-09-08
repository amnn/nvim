local p = require "config.packages"

local function setup()
  require("which-key").setup {}
  vim.keymap.set(
    "n",
    "<leader>?",
    function() require("which-key").show { global = false } end,
    { desc = "Buffer local Keymaps (Which Key)" }
  )
end

p.eager {
  p.github("folke/which-key.nvim", vim.version.range "*"),
  p.github "nvim-tree/nvim-web-devicons",
}
setup()
