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

-- Fugitive calls browse handlers only when :GBrowse runs, so using :G does
-- not load Rhubarb.
vim.cmd [[
  function! ConfigRhubarbBrowse(opts) abort
    lua require("lz.n").trigger_load("vim-rhubarb")
    return rhubarb#FugitiveUrl(a:opts)
  endfunction

  let g:fugitive_browse_handlers = [function('ConfigRhubarbBrowse')]
]]

require("lz.n").load {
  {
    "vim-rhubarb",
    lazy = true,
  },
}
