-- Search
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Indenting
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- TODO: Waiting for treesitter foldtext support to be released.
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

-- Word-wrap
vim.opt.linebreak = true

-- Gutter
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Scrolling
vim.opt.scrolloff = 5

-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Basic Keybinds
local map = vim.keymap.set

map("i", "jk", "<Esc>")
map({ "n", "x", "o" }, "\\", ";", { remap = false })
map({ "n", "x", "o" }, "j", "gj", { remap = false })
map({ "n", "x", "o" }, "gj", "j", { remap = false })
map({ "n", "x", "o" }, "k", "gk", { remap = false })
map({ "n", "x", "o" }, "gk", "k", { remap = false })

-- Snippets
map({ "i", "s" }, "<C-f>", function()
  if vim.snippet.active { direction = 1 } then
    return [[<CMD>lua vim.snippet.jump(1)<CR>]]
  else
    return "<C-f>"
  end
end, { expr = true })

map({ "i", "s" }, "<C-b>", function()
  if vim.snippet.active { direction = -1 } then
    return [[<CMD>lua vim.snippet.jump(-1)<CR>]]
  else
    return "<C-b>"
  end
end, { expr = true })

map({ "i", "s" }, "<C-c>", function()
  if vim.snippet.active() then
    return [[<CMD>lua vim.snippet.stop()<CR>]]
  else
    return "<C-c>"
  end
end, { expr = true })

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

require "config.lazy"

-- TODO: Set-up repo.

-- TODO: Re-try vim-fugitive
-- TODO: Try fzf-lua

-- Projects Keybindings
-- TODO: Search (ripgrep) in project root
-- TODO: Open Fugitive Status

-- DAP
-- TODO: Rust: Code LLDB + DAP UI (+ VSCode Icon font)

-- Move
-- TODO: Tree Sitter
-- TODO: Move Analyzer

-- TODO: Investigate issue with nvim taking a while to close:
-- nvim -V10vim.log will offer debug of what is going on.
