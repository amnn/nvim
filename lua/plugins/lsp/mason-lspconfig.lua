require("lz.n").load {
  {
    "mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    before = function() require("lz.n").trigger_load "mason.nvim" end,
    after = function()
      require("mason-lspconfig").setup {
        automatic_enable = false,
      }
    end,
  },
}
