require("lz.n").load {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lualine").setup {
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str) return str:sub(1, 1) end,
            },
          },
        },
      }
    end,
  },
}
