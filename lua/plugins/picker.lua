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
        "<leader>b",
        function() require("telescope.builtin").buffers() end,
        desc = "Choose [b]uffer (Telescope)",
      },
      {
        "<leader>f",
        function() require("telescope.builtin").find_files() end,
        desc = "Choose [f]iles (Telescope)",
      },
      {
        "<leader>F",
        function() require("telescope.builtin").oldfiles() end,
        desc = "Previously opened [f]iles (Telescope)",
      },
      {
        "<leader>g",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Rip[g]rep (Telescope)",
      },
      {
        "<leader>s",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "[S]earch lines in buffer (Telescope)",
      },
      {
        "<leader>x",
        function() require("telescope.builtin").commands() end,
        desc = "Commands to e[x]ecute (Telescope)",
      },
      {
        "<leader>k",
        function() require("telescope.builtin").keymaps() end,
        desc = "List [k]eymaps (Telescope)",
      },
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
      {
        "ge",
        function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
        desc = "List [e]rrors in file (Telescope)",
      },
      {
        "gE",
        function() require("telescope.builtin").diagnostics() end,
        desc = "List [E]rrors in workspace (Telescope)",
      },
      {
        "gs",
        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        desc = "List [s]ymbols in workspace (Telescope)",
      },
      {
        "<leader>r",
        function() vim.lsp.buf.rename() end,
        desc = "[R]ename symbol (LSP)",
      },
      {
        "gi",
        function() require("telescope.builtin").lsp_implementations() end,
        desc = "List [i]mplementations (Telescope)",
      },
      {
        "gd",
        function() require("telescope.builtin").lsp_definitions() end,
        desc = "List [d]efinitions (Telescope)",
      },
      {
        "gr",
        function() require("telescope.builtin").lsp_references() end,
        desc = "List [r]eferences (Telescope)",
      },
      {
        "gy",
        function() require("telescope.builtin").lsp_type_definitions() end,
        desc = "List t[y]pe definitions (Telescope)",
      },
      {
        "gCi",
        function() require("telescope.builtin").lsp_incoming_calls() end,
        desc = "List [i]ncoming [c]alls (Telescope)",
      },
      {
        "gCo",
        function() require("telescope.builtin").lsp_outgoing_calls() end,
        desc = "List [o]utgoing [c]alls (Telescope)",
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
