local p = require "config.packages"

local function setup()
  vim.api.nvim_create_user_command(
    "Browse",
    function(opts) vim.fn.system { "open", opts.fargs[1] } end,
    { nargs = 1, desc = "Open URL in [Browse]r" }
  )

  vim.keymap.set("n", "gh", [[:0GBrowse<CR>]], {
    desc = "Open on [G]it[H]ub (Fugitive)",
  })

  vim.keymap.set("v", "gh", [[:'<,'>GBrowse<CR>]], {
    desc = "Open selection on [G]it[H]ub (Fugitive)",
  })

  vim.keymap.set("n", "gH", [[:0GBrowse!<CR>]], {
    desc = "Copy [G]it[H]ub URL (Fugitive)",
  })

  vim.keymap.set("v", "gH", [[:'<,'>GBrowse!<CR>]], {
    desc = "Copy [G]it[H]ub URL for selection (Fugitive)",
  })
end

p.eager { p.github "tpope/vim-rhubarb" }
setup()
