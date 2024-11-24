return {
  {
    "github/copilot.vim",
    version = "*",
    init = function() vim.g.copilot_no_tab_map = true end,
    lazy = false,
    keys = {
      {
        "<S-Tab>",
        mode = { "i", "n" },
        'copilot#Accept("\\<CR>")',
        expr = true,
        replace_keycodes = false,
        desc = "Accept suggestion (Copilot)",
      },
    },
  },
}
