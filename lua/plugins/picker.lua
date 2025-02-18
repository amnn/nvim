return {
  {
    "ahmedkhalf/project.nvim",
    version = "*",
    events = { "VeryLazy" },
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern" },
        patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer local Keymaps (Which Key)",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        width = 0.6,
        backdrop = 100,
        preview = {
          layout = "flex",
          flip_columns = 200,
        },
      },
    },
    keys = {
      {
        "<leader>b",
        function() require("fzf-lua").buffers() end,
        desc = "Choose [b]uffer (fzf)",
      },
      {
        "<leader>f",
        function() require("fzf-lua").files() end,
        desc = "Choose [f]iles (fzf)",
      },
      {
        "<leader>F",
        function() require("fzf-lua").oldfiles() end,
        desc = "Previously opened [f]iles (fzf)",
      },
      {
        "<leader>g",
        function() require("fzf-lua").live_grep_glob() end,
        desc = "Rip[g]rep (fzf)",
      },
      {
        "<leader>G",
        function() require("fzf-lua").live_grep_resume() end,
        desc = "Resume rip[g]rep (fzf)",
      },
      {
        "<leader>k",
        function() require("fzf-lua").keymaps() end,
        desc = "List [k]eymaps (fzf)",
      },
      {
        "<leader>p",
        function()
          local fzf = require "fzf-lua"
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
                fn = function(ps) fzf.live_grep_glob { cwd = ps[1] } end,
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

                    -- Deleting multiple projects at a time doesn't work
                    -- because deleting a project causes holes in the
                    -- `recent_projects` list, so after each deletion, we save
                    -- and restore from the file.
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
        end,
        desc = "Open [p]roject (fzf)",
      },
      {
        "<leader>s",
        function() require("fzf-lua").blines() end,
        desc = "[S]earch lines in buffer (fzf)",
      },
      {
        "<leader>x",
        function() require("fzf-lua").commands() end,
        desc = "Commands to e[x]ecute (fzf)",
      },
      {
        "ge",
        function() require("fzf-lua").lsp_document_diagnostics() end,
        desc = "List [e]rrors in file (fzf)",
      },
      {
        "gE",
        function() require("fzf-lua").lsp_workspace_diagnostics() end,
        desc = "List [E]rrors in workspace (fzf)",
      },
      {
        "gs",
        function() require("fzf-lua").lsp_workspace_symbols() end,
        desc = "List [s]ymbols in workspace (fzf)",
      },
      {
        "<leader>r",
        function() vim.lsp.buf.rename() end,
        desc = "[R]ename symbol (LSP)",
      },
      {
        "<leader>a",
        function() require("fzf-lua").lsp_code_actions() end,
        desc = "Code [a]ctions (fzf)",
      },
      {
        "gi",
        function() require("fzf-lua").lsp_implementations { jump1 = true } end,
        desc = "List [i]mplementations (fzf)",
      },
      {
        "gd",
        function() require("fzf-lua").lsp_definitions { jump1 = true } end,
        desc = "List [d]efinitions (fzf)",
      },
      {
        "gr",
        function() require("fzf-lua").lsp_references { jump1 = true } end,
        desc = "List [r]eferences (fzf)",
      },
      {
        "gy",
        function() require("fzf-lua").lsp_typedefs { jump1 = true } end,
        desc = "List t[y]pe definitions (fzf)",
      },
      {
        "gCi",
        function() require("fzf-lua").lsp_incoming_calls { jump1 = true } end,
        desc = "List [i]ncoming [c]alls (fzf)",
      },
      {
        "gCo",
        function() require("fzf-lua").lsp_outgoing_calls { jump1 = true } end,
        desc = "List [o]utgoing [c]alls (fzf)",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    version = "*",
    opts = {
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
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "-",
        function() require("oil").open(vim.fn.expand "%:h") end,
        desc = "Open parent directory (Oil)",
      },
      {
        "_",
        function() require("oil").open(vim.fn.getcwd()) end,
        desc = "Open Neovim's current working directory (Oil)",
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    version = "*",
    event = "FileType qf",
    opts = {
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
    },
  },
}
