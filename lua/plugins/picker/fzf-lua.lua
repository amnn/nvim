local p = require "config.packages"

local function setup()
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
            local choice =
              vim.fn.confirm("Delete " .. #ps .. " project(s)?", "&Yes\n&No", 2)

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
end

p.eager {
  p.github "ibhagwan/fzf-lua",
  p.github "nvim-tree/nvim-web-devicons",
}
setup()
