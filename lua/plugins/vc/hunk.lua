local p = require "config.packages"

local function setup()
  require("hunk").setup {
    hooks = {
      on_tree_mount = function(context)
        vim.api.nvim_set_option_value(
          "wrap",
          false,
          { win = context.opts.winid }
        )
      end,
    },
  }
end

p.lazy {
  p.github "julienvincent/hunk.nvim",
  p.github "MunifTanjim/nui.nvim",
  p.github "nvim-tree/nvim-web-devicons",
}

require("lz.n").load {
  {
    "hunk.nvim",
    cmd = "DiffEditor",
    before = function()
      vim.cmd.packadd "nui.nvim"
      vim.cmd.packadd "nvim-web-devicons"
    end,
    after = setup,
  },
}
