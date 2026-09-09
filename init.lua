-- Match macOS appearance before loading the theme; dark-notify handles later changes.
local interface_style = vim.fn.system { "defaults", "read", "-g", "AppleInterfaceStyle" }
vim.opt.background = vim.trim(interface_style) == "Dark" and "dark" or "light"

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
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars:append {
  fold = " ",
  foldclose = "",
  foldinner = " ",
  foldopen = "",
  foldsep = " ",
}

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

-- Cursor Hold
vim.opt.updatetime = 1500

-- Floating Windows
vim.opt.winborder = "rounded"

-- Terminal title
vim.opt.title = true
vim.opt.titlestring = [[nvim - %{%pathshorten(fnamemodify(getcwd(), ':~'))%}]]

-- Basic Keybinds
local map = vim.keymap.set

map("i", "jk", "<Esc>")
map({ "n", "x", "o" }, "\\", ";", { remap = false })
map({ "n", "x", "o" }, "j", "gj", { remap = false })
map({ "n", "x", "o" }, "gj", "j", { remap = false })
map({ "n", "x", "o" }, "k", "gk", { remap = false })
map({ "n", "x", "o" }, "gk", "k", { remap = false })

-- Moving lines
map({ "n" }, "<A-j>", "<CMD>m +1<CR>")
map({ "n" }, "<A-k>", "<CMD>m -2<CR>")
map({ "i" }, "<A-j>", "<CMD>m +1<CR>")
map({ "i" }, "<A-k>", "<CMD>m -2<CR>")
map({ "v" }, "<A-j>", ":m '>+1<CR>gv")
map({ "v" }, "<A-k>", ":m '<-2<CR>gv")

-- Snippets
map({ "i", "s" }, "<C-c>", function()
  if vim.snippet.active() then
    return [[<CMD>lua vim.snippet.stop()<CR>]]
  else
    return "<C-c>"
  end
end, { expr = true })

-- Define leaders before plugin mappings are created.
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

require "config.pack"
