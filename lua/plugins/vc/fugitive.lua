local p = require "config.packages"

local function setup()
  vim.keymap.set("n", "<leader>v", [[<CMD>tab G<CR>]], {
    desc = "Open [v]ersion control (Fugitive)",
  })

  vim.keymap.set("n", "gB", [[<CMD>G blame<CR>]], {
    desc = "Toggle [g]it [B]lame for file (Fugitive)",
  })
end

p.lazy { p.github "tpope/vim-fugitive" }
setup()

require("lz.n").load {
  {
    "vim-fugitive",
    cmd = {
      "G",
      "GBrowse",
      "GDelete",
      "GMove",
      "GRemove",
      "GRename",
      "GUnlink",
      "Gblame",
      "Gbrowse",
      "GcLog",
      "Gcd",
      "Gclog",
      "Gcommit",
      "Gdelete",
      "Gdiffsplit",
      "Ge",
      "Gedit",
      "Gfetch",
      "Ggrep",
      "Ghdiffsplit",
      "Git",
      "GlLog",
      "Glcd",
      "Glgrep",
      "Gllog",
      "Glog",
      "Gmerge",
      "Gmove",
      "Gpedit",
      "Gpull",
      "Gpush",
      "Gr",
      "Gread",
      "Grebase",
      "Gremove",
      "Grename",
      "Grevert",
      "Gsplit",
      "Gstatus",
      "Gtabedit",
      "Gvdiffsplit",
      "Gvsplit",
      "Gw",
      "Gwq",
      "Gwrite",
    },
    after = function() require("lz.n").trigger_load "vim-rhubarb" end,
  },
}
