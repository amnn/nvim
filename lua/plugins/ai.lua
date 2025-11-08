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
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "n",
    false
  )
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
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<C-,>",
        "<cmd>ClaudeCodeFocus<CR>",
        desc = "Claude Code",
        mode = { "n", "x" },
      },
      { "<LocalLeader>a", nil, desc = "[A]I/Claude" },
      {
        "<LocalLeader>ar",
        "<CMD>ClaudeCode --resume<CR>",
        desc = "[R]esume [A]I/Claude",
      },
      {
        "<LocalLeader>aC",
        "<CMD>ClaudeCode --continue<CR>",
        desc = "[C]ontinue [A]I/Claude",
      },
      {
        "<LocalLeader>am",
        "<cmd>ClaudeCodeSelectModel<cr>",
        desc = "Select [A]I/Claude [M]odel",
      },
      {
        "<LocalLeader>ab",
        "<cmd>ClaudeCodeAdd %<cr>",
        desc = "Add current [B]uffer for [A]I/Claude",
      },
      {
        "<LocalLeader>as",
        "<cmd>ClaudeCodeSend<cr>",
        mode = "v",
        desc = "[S]end to [A]I/Claude",
      },
      {
        "<LocalLeader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "[S]end file to [A]I/Claude",
        ft = { "oil" },
      },
      -- Diff management
      {
        "<LocalLeader>aa",
        "<cmd>ClaudeCodeDiffAccept<cr>",
        desc = "[A]ccept diff from [A]I/Claude",
      },
      {
        "<LocalLeader>ad",
        "<cmd>ClaudeCodeDiffDeny<cr>",
        desc = "[D]eny diff from [A]I/Claude",
      },
    },

    opts = {
      terminal = {
        snacks_win_opts = {
          position = "float",
          width = function(self)
            if vim.o.columns < 200 then
              return 0.8 -- Center on small screens with more width
            else
              return 0.35
            end
          end,
          height = 0.9,
          border = "none", -- No border
          col = function(self)
            if vim.o.columns < 200 then
              return 0.1 -- Center horizontally (0.1 + 0.8 width = 0.9, leaving 0.1 on right)
            else
              return 0.64
            end
          end,
          keys = {
            claude_hide = {
              "<C-,>",
              function(self) self:hide() end,
              mode = "t",
              desc = "Hide",
            },
          },
        },
      },
    },
  },
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
}
