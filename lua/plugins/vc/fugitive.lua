vim.keymap.set("n", "<leader>v", [[<CMD>tab G<CR>]], {
  desc = "Open [v]ersion control (Fugitive)",
})

vim.keymap.set("n", "gB", [[<CMD>G blame<CR>]], {
  desc = "Toggle [g]it [B]lame for file (Fugitive)",
})

require("lz.n").load {
  {
    "vim-fugitive",
    cmd = { "G", "GBrowse" },
  },
}
