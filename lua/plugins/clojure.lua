vim.api.nvim_create_user_command("Scratch", function()
  if pcall(vim.cmd, [[b scratch]]) then return end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "scratch")
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("filetype", "clojure", { buf = buf })
  vim.api.nvim_set_current_buf(buf)
end, { desc = "Open a new [Scratch] buffer." })

return {
  {
    "PaterJason/cmp-conjure",
    version = "*",
    lazy = true,
    config = function()
      local cmp = require "cmp"
      local cfg = cmp.get_config()
      table.insert(cfg, { name = "conjure" })
      return cmp.setup(cfg)
    end,
  },
  {
    "Olical/conjure",
    version = "*",
    dependenceies = {
      "PaterJason/cmp-conjure",
    },
    ft = { "clojure" },
    lazy = true,
    init = function()
      vim.g["conjure#filetypes"] = {
        "clojure",
        "fennel",
        "janet",
        "hy",
        "racket",
        "scheme",
        "lisp",
        "sql",
      }
    end,
  },
  {
    "clojure-vim/vim-jack-in",
    version = "*",
    dependenceies = {
      "radenling/vim-dispatch-neovim",
      "tpope/vim-dispatch",
    },
    commands = { "Clj", "Boot", "Lein" },
  },
}
