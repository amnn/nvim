local github = require("config.packages").github

return {
  packages = {
    github(
      "ahmedkhalf/project.nvim",
      "8c6bad7d22eef1b71144b401c9f74ed01526a4fb"
    ),
    github("folke/which-key.nvim", "fcbf4eea17cb299c02557d576f0d568878e354a4"),
    github("ibhagwan/fzf-lua", "05e44d38de0a79c11fba5f7bf8138791b1dbdd1e"),
    github(
      "nvim-tree/nvim-web-devicons",
      "2ae6958df7ced50baac5035cec0c15799eedfbf7"
    ),
    github("stevearc/oil.nvim", "17c0a8faaf48298a0c0cfb0d757c0eaee4ff7a32"),
    github("stevearc/quicker.nvim", "4a6883cb13fe097a20a046eb55f6dffd239276e3"),
  },
  configure = function()
    require("project_nvim").setup {
      detection_methods = { "pattern" },
      patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
    }

    require("which-key").setup {}
    vim.keymap.set(
      "n",
      "<leader>?",
      function() require("which-key").show { global = false } end,
      { desc = "Buffer local Keymaps (Which Key)" }
    )

    local fzf = require "fzf-lua"
    fzf.setup {
      winopts = {
        width = 0.6,
        backdrop = 100,
        preview = {
          layout = "flex",
          flip_columns = 200,
        },
      },
    }
    fzf.register_ui_select()

    local map = vim.keymap.set

    map("n", "<leader>b", function() fzf.buffers() end, {
      desc = "Choose [b]uffer (fzf)",
    })
    map("n", "<leader>f", function() fzf.files() end, {
      desc = "Choose [f]iles (fzf)",
    })
    map("n", "<leader>F", function() fzf.oldfiles() end, {
      desc = "Previously opened [f]iles (fzf)",
    })
    map("n", "<leader>g", function() fzf.live_grep() end, {
      desc = "Rip[g]rep (fzf)",
    })
    map("n", "<leader>G", function() fzf.live_grep_resume() end, {
      desc = "Resume rip[g]rep (fzf)",
    })
    map("n", "<leader>k", function() fzf.keymaps() end, {
      desc = "List [k]eymaps (fzf)",
    })
    map("n", "<leader>p", function()
      local history = require "project_nvim.utils.history"

      -- Use a function for contents, so that after deletion, the recent
      -- projects are loaded fresh.
      local function fzf_recent_projects(yield)
        local projects = history.get_recent_projects()
        for i = #projects, 1, -1 do
          yield(fzf.path.HOME_to_tilde(projects[i]))
        end
        yield()
      end

      local opts = {
        header_separator = " | ",
        fzf_opts = {
          ["--multi"] = true,
          ["--prompt"] = "Projects> ",
        },
        actions = {
          ["default"] = function(ps) fzf.files { cwd = ps[1] } end,
          ["ctrl-g"] = {
            fn = function(ps) fzf.live_grep { cwd = ps[1] } end,
            header = "Grep",
          },
          ["ctrl-v"] = {
            fn = function(ps)
              vim.cmd.tabedit(ps[1])
              vim.cmd.G()
            end,
            header = "Open VC",
          },
          ["ctrl-x"] = {
            function(ps)
              local choice = vim.fn.confirm(
                "Delete " .. #ps .. " project(s)?",
                "&Yes\n&No",
                2
              )

              if choice == 2 then return end

              for _, project in ipairs(ps) do
                history.delete_project {
                  value = project:gsub("~", vim.env.HOME),
                }

                -- Deleting multiple projects at a time doesn't work because
                -- deleting a project causes holes in the `recent_projects`
                -- list, so after each deletion, save and restore the file.
                history.write_projects_to_history()
                history.read_projects_from_history()
              end
            end,
            fzf.actions.resume,
            header = "Delete project(s)",
          },
        },
      }

      opts = fzf.config.normalize_opts(opts, {})
      opts = fzf.core.set_header(opts, { "actions" })

      fzf.fzf_exec(fzf_recent_projects, opts)
    end, { desc = "Open [p]roject (fzf)" })
    map("n", "<leader>s", function() fzf.blines() end, {
      desc = "[S]earch lines in buffer (fzf)",
    })
    map("n", "<leader>x", function() fzf.commands() end, {
      desc = "Commands to e[x]ecute (fzf)",
    })
    map("n", "ge", function() fzf.lsp_document_diagnostics() end, {
      desc = "List [e]rrors in file (fzf)",
    })
    map("n", "gE", function() fzf.lsp_workspace_diagnostics() end, {
      desc = "List [E]rrors in workspace (fzf)",
    })
    map("n", "gs", function() fzf.lsp_workspace_symbols() end, {
      desc = "List [s]ymbols in workspace (fzf)",
    })
    map("n", "<leader>r", function() vim.lsp.buf.rename() end, {
      desc = "[R]ename symbol (LSP)",
    })
    map("n", "<leader>a", function() fzf.lsp_code_actions() end, {
      desc = "Code [a]ctions (fzf)",
    })
    map("n", "gi", function() fzf.lsp_implementations { jump1 = true } end, {
      desc = "List [i]mplementations (fzf)",
    })
    map("n", "gd", function() fzf.lsp_definitions { jump1 = true } end, {
      desc = "List [d]efinitions (fzf)",
    })
    map("n", "gr", function() fzf.lsp_references { jump1 = true } end, {
      desc = "List [r]eferences (fzf)",
    })
    map("n", "gy", function() fzf.lsp_typedefs { jump1 = true } end, {
      desc = "List t[y]pe definitions (fzf)",
    })
    map("n", "gCi", function() fzf.lsp_incoming_calls { jump1 = true } end, {
      desc = "List [i]ncoming [c]alls (fzf)",
    })
    map("n", "gCo", function() fzf.lsp_outgoing_calls { jump1 = true } end, {
      desc = "List [o]utgoing [c]alls (fzf)",
    })

    require("oil").setup {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        is_hidden_file = function(name, _)
          return name ~= ".." and vim.startswith(name, ".")
        end,
      },
      win_options = {
        winbar = "%{v:lua.require('oil').get_current_dir()}",
      },
    }

    map("n", "-", function() require("oil").open(vim.fn.expand "%:h") end, {
      desc = "Open parent directory (Oil)",
    })
    map("n", "_", function() require("oil").open(vim.fn.getcwd()) end, {
      desc = "Open Neovim's current working directory (Oil)",
    })

    require("quicker").setup {
      keys = {
        {
          ">",
          function()
            require("quicker").expand {
              before = 2,
              after = 2,
              add_to_existing = true,
            }
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function() require("quicker").collapse() end,
          desc = "Collapse quickfix context",
        },
      },
    }
  end,
}
