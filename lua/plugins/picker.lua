return {
  {
    "ahmedkhalf/project.nvim",
    version = "*",
    events = { "VeryLazy" },
    config = function()
      require("project_nvim").setup {
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    version = "*",
    opts = {},
    cmd = "Trouble",
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
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "ahmedkhalf/project.nvim",
      "folke/trouble.nvim",
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },

    config = function()
      local actions = require "telescope.actions"
      local grep_actions = require "telescope-live-grep-args.actions"
      local telescope = require "telescope"
      local trouble = require "trouble.sources.telescope"

      telescope.setup {
        defaults = vim.tbl_deep_extend(
          "force",
          require("telescope.themes").get_ivy(),
          {
            mappings = {
              i = {
                ["<C-t>"] = trouble.open,
                ["<C-a>"] = trouble.add,
              },
              n = {
                ["<C-t>"] = trouble.open,
                ["<C-a>"] = trouble.add,
              },
            },
          }
        ),

        extensions = {
          live_grep_args = {
            mappings = {
              i = {
                ["<C-k>"] = grep_actions.quote_prompt(),
                ["<C-space>"] = actions.to_fuzzy_refine,
              },
            },
          },
          projects = {
            mappings = {
              i = {
                -- ["<C-v>"] = Open VC
                -- ["<C-g>"] = Live Grep with args
              },
              n = {
                -- ["v"] = Open VC
                -- ["g"] = Live Grep with args
              },
            },
          },
        },
      }

      telescope.load_extension "fzf"
      telescope.load_extension "live_grep_args"
      telescope.load_extension "projects"
      telescope.load_extension "ui-select"
    end,

    keys = {
      {
        "<leader>p",
        -- Projects lazy loads the list of projects on setup, so we make sure
        -- this package is not loaded lazily, and we set-up its keybinding in
        -- telescope instead.
        function() require("telescope").extensions.projects.projects {} end,
        desc = "Choose [p]roject (Telescope/Projects)",
      },
      {
        "<leader>P",
        -- Duplicate of above keybinding, because I'm very used to using the
        -- capital letter version.
        function() require("telescope").extensions.projects.projects {} end,
        desc = "Choose [P]roject (Telescope/Projects)",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        width = 0.6,
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
        "<leader>k",
        function() require("fzf-lua").keymaps() end,
        desc = "List [k]eymaps (fzf)",
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
        function()
          require("fzf-lua").lsp_implementations { jump_to_single_result = true }
        end,
        desc = "List [i]mplementations (fzf)",
      },
      {
        "gd",
        function()
          require("fzf-lua").lsp_definitions { jump_to_single_result = true }
        end,
        desc = "List [d]efinitions (fzf)",
      },
      {
        "gr",
        function()
          require("fzf-lua").lsp_references { jump_to_single_result = true }
        end,
        desc = "List [r]eferences (fzf)",
      },
      {
        "gy",
        function()
          require("fzf-lua").lsp_typedefs { jump_to_single_result = true }
        end,
        desc = "List t[y]pe definitions (fzf)",
      },
      {
        "gCi",
        function()
          require("fzf-lua").lsp_incoming_calls { jump_to_single_result = true }
        end,
        desc = "List [i]ncoming [c]alls (fzf)",
      },
      {
        "gCo",
        function()
          require("fzf-lua").lsp_outgoing_calls { jump_to_single_result = true }
        end,
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
}
