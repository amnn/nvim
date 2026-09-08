require("lz.n").load {
  {
    "hunk.nvim",
    cmd = "DiffEditor",
    before = function()
      vim.cmd.packadd "nui.nvim"
      vim.cmd.packadd "nvim-web-devicons"
    end,
    after = function()
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
    end,
  },
}
