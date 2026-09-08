require("lz.n").load {
  {
    "oil.nvim",
    cmd = "Oil",
    before = function() vim.cmd.packadd "nvim-web-devicons" end,
    keys = {
      {
        "-",
        function() require("oil").open(vim.fn.expand "%:h") end,
        desc = "Open parent directory (Oil)",
      },
      {
        "_",
        function() require("oil").open(vim.fn.getcwd()) end,
        desc = "Open Neovim's current working directory (Oil)",
      },
    },
    after = function()
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
    end,
  },
}
