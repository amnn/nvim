require("lz.n").load {
  {
    "mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonLog",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonUpdate",
    },
    after = function() require("mason").setup {} end,
  },
}
