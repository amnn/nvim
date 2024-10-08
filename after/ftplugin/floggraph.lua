local map = vim.keymap.set

-- Prepare a `git` command for execution, but don't run it, so that the user
-- can confirm or modify it.
--
-- The template is first resolved with `flog#Format`, which will resolve ref
-- names, commit SHA's etc. It then goes through `nvim_replace_termcodes` to
-- parse key codes, like `<C-b>` etc. Finally, it is passed through `feedkeys`
-- which emulates the template as keypresses, without remapping.
local function prep(template)
  return function()
    local cmd = vim.fn.call("flog#Format", { ":Floggit " .. template })
    local escaped = vim.api.nvim_replace_termcodes(cmd, true, true, true)
    vim.fn.feedkeys(escaped, "n")
  end
end

-- Execute a `git` command directly, without user confirmation.
--
-- The template is resolved with `flog#Format` which will resolve ref names,
-- commit SHA's etc.
local function exec(template)
  return function()
    local cmd = vim.fn.call("flog#Format", { ":Floggit " .. template })
    vim.cmd(cmd)
  end
end

map(
  "n",
  "bc",
  prep "branch %h<C-b><C-right><C-right> ",
  { buffer = true, desc = "[C]reate [b]ranch (Floggraph)" }
)

map(
  "n",
  "bd",
  prep "branch -d %b",
  { buffer = true, desc = "[D]elete [b]ranch (Floggraph)" }
)

map(
  "n",
  "bD",
  prep "branch -D %b",
  { buffer = true, desc = "Force [d]elete [b]ranch (Floggraph)" }
)

map(
  "n",
  "bu",
  prep "update-ref refs/heads/",
  { buffer = true, desc = "[U]pdate [b]ranch (Floggraph)" }
)

map(
  "n",
  "p",
  exec "push origin %b",
  { buffer = true, desc = "[P]ush (Floggraph)" }
)
map(
  "n",
  "P",
  exec "push --force-with-lease origin %b",
  { buffer = true, desc = "Force [p]ush (Floggraph)" }
)
