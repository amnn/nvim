local map = vim.keymap.set

-- Override `i` in quickfix lists. These buffers are already non-modifiable, so
-- we simulate modification using `replacer`.
map("n", "i", function() require("replacer").run() end, { buffer = true })
