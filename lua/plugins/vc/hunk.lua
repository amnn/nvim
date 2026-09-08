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

p.eager {
  p.github "MunifTanjim/nui.nvim",
  p.github "nvim-tree/nvim-web-devicons",
}
p.lazy { p.github "julienvincent/hunk.nvim" }

require("lz.n").load {
  {
    "hunk.nvim",
    cmd = "DiffEditor",
    after = setup,
  },
}
