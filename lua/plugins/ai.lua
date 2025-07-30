-- Keybindings for copying file paths and regions to clipboard
vim.keymap.set("n", "<leader>yf", function()
  local filepath = vim.fn.expand "%:p"
  vim.fn.setreg("+", filepath)
  print("Copied file path: " .. filepath)
end, { desc = "[Y]ank [f]ile path" })

vim.keymap.set("n", "<leader>yl", function()
  local filepath = vim.fn.expand "%:p"
  local line = vim.fn.line "."
  local result = filepath .. ":" .. line
  vim.fn.setreg("+", result)
  print("Copied file:line: " .. result)
end, { desc = "[Y]ank file path with [l]ine number" })

vim.keymap.set("v", "<leader>yl", function()
  -- Exit visual mode first to ensure marks are set
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
  vim.schedule(function()
    local filepath = vim.fn.expand "%:p"
    local start_line = vim.fn.line "'<"
    local end_line = vim.fn.line "'>"
    local result = filepath .. ":" .. start_line .. "-" .. end_line
    vim.fn.setreg("+", result)
    print("Copied file:region: " .. result)
  end)
end, { desc = "[Y]ank file path with [l]ine range" })

return {
  {
    "github/copilot.vim",
    version = "*",
    init = function() vim.g.copilot_no_tab_map = true end,
    lazy = false,
    keys = {
      {
        "<S-Tab>",
        mode = { "i", "n" },
        'copilot#Accept("\\<CR>")',
        expr = true,
        replace_keycodes = false,
        desc = "Accept suggestion (Copilot)",
      },
    },
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      window = {
        position = "float",
        float = {
          width = "30%",
          height = "95%",
          row = 1,
          col = "70%",
        },

        keymaps = {
          toggle = {
            normal = "<C-,>",
            terminal = "<C-,>",
          },
        },
      },
    },
  },
}
