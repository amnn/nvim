return {
  {
    "ahmedkhalf/project.nvim",

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
    opts = {},
    cmd = "Trouble",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
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
        desc = "Choose [b]uffer",
      },
      {
        "<leader>f",
        function() require("telescope.builtin").find_files() end,
        desc = "Choose [f]iles",
      },
      {
        "<leader>F",
        function() require("telescope.builtin").oldfiles() end,
        desc = "Previously opened [f]iles",
      },
      {
        "<leader>g",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Rip[g]rep",
      },
      {
        "<leader>s",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "[S]earch lines in buffer",
      },
      {
        "<leader>x",
        function() require("telescope.builtin").commands() end,
        desc = "Commands to e[x]ecute",
      },
      {
        "<leader>k",
        function() require("telescope.builtin").keymaps() end,
        desc = "List [k]eymaps",
      },
      {
        "<leader>p",
        -- Projects lazy loads the list of projects on setup, so we make sure
        -- this package is not loaded lazily, and we set-up its keybinding in
        -- telescope instead.
        function() require("telescope").extensions.projects.projects {} end,
        desc = "Choose [p]roject",
      },
      {
        "<leader>P",
        -- Duplicate of above keybinding, because I'm very used to using the
        -- capital letter version.
        function() require("telescope").extensions.projects.projects {} end,
        desc = "Choose [P]roject",
      },
      {
        "ge",
        function() require("telescope.builtin").diagnostics { bufnr = 0 } end,
        desc = "List [e]rrors in file",
      },
      {
        "gE",
        function() require("telescope.builtin").diagnostics() end,
        desc = "List [E]rrors in workspace",
      },
      {
        "gs",
        function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        desc = "List [s]ymbols in workspace",
      },
      {
        "<leader>r",
        function() vim.lsp.buf.rename() end,
        desc = "[R]ename symbol",
      },
      {
        "gi",
        function() require("telescope.builtin").lsp_implementations() end,
        desc = "List [i]mplementations",
      },
      {
        "gd",
        function() require("telescope.builtin").lsp_definitions() end,
        desc = "List [d]efinitions",
      },
      {
        "gr",
        function() require("telescope.builtin").lsp_references() end,
        desc = "List [r]eferences",
      },
      {
        "gy",
        function() require("telescope.builtin").lsp_type_definitions() end,
        desc = "List t[y]pe definitions",
      },
      {
        "gCi",
        function() require("telescope.builtin").lsp_incoming_calls() end,
        desc = "List [i]ncoming [c]alls",
      },
      {
        "gCo",
        function() require("telescope.builtin").lsp_outgoing_calls() end,
        desc = "List [o]utgoing [c]alls",
      },
    },
  },
  {
    "stevearc/oil.nvim",
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
        desc = "Open parent directory in Oil",
      },
      {
        "_",
        desc = "Open Neovim's current working directory in Oil.",
        function() require("oil").open(vim.fn.getcwd()) end,
      },
    },
  },
}
