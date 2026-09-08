local p = require "config.packages"

local function setup()
  require("oil").setup {
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    view_options = {
      is_hidden_file = function(name, _)
        return name ~= ".." and vim.startswith(name, ".")
      end,
    },
    win_options = {
      winbar = "%{v:lua.require('oil').get_current_dir()}",
    },
  }

  vim.keymap.set(
    "n",
    "-",
    function() require("oil").open(vim.fn.expand "%:h") end,
    { desc = "Open parent directory (Oil)" }
  )
  vim.keymap.set(
    "n",
    "_",
    function() require("oil").open(vim.fn.getcwd()) end,
    { desc = "Open Neovim's current working directory (Oil)" }
  )
end

p.eager {
  p.github("stevearc/oil.nvim", vim.version.range "*"),
  p.github "nvim-tree/nvim-web-devicons",
}
setup()
