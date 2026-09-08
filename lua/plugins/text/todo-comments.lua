require("lz.n").load {
  {
    "todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "TodoFzfLua",
      "TodoLocList",
      "TodoQuickFix",
      "TodoTelescope",
      "TodoTrouble",
    },
    after = function()
      local todo = require "todo-comments"
      todo.setup {
        highlight = {
          before = "",
          after = "",
          keyword = "fg",
          pattern = [[.*<(KEYWORDS)>]],
        },
        search = {
          pattern = [[\b(KEYWORDS)\b]],
        },
      }

      local config = require "todo-comments.config"
      if not config.loaded then
        vim.wait(1000, function() return config.loaded end)
      end

      vim.api.nvim_create_user_command("TodoFzfLua", function(args)
        require("lz.n").trigger_load "fzf-lua"
        vim.cmd.lua("require('todo-comments.fzf').todo() " .. args.args)
      end, { nargs = "*", force = true })
    end,
  },
}
