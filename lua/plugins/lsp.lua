return {
  {
    "amnn/lsp-echohint.nvim",
    opts = {},
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    version = "*",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    version = "*",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "petertriho/cmp-git",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args) vim.snippet.expand(args.body) end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert(),

        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      }

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    version = "*",
    opts = {
      notification = {
        window = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    version = "*",
    events = { "VeryLazy" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lsp = require "lspconfig"
      local configs = require "lspconfig.configs"
      local capabilities = vim.tbl_deep_extend(
        "force",
        require("cmp_nvim_lsp").default_capabilities(),
        {
          workspace = {
            didChangeWatchedFiles = {
              -- Disable workspace/didChangeWatchedFiles. It causes issues in
              -- large projects, where the file watcher opens too many files.
              dynamicRegistration = false,
            },
          },
        }
      )

      if not configs.move then
        configs.move = {
          default_config = {
            cmd = { "move-analyzer" },
            filetypes = { "move" },
            root_dir = lsp.util.root_pattern "Move.toml",
          },
        }
      end

      -- Render a border around the floating window that shows docs.
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })

      lsp.lua_ls.setup {
        capabilities = capabilities,
        on_init = function(client)
          local path = client.workspace_folders[1].name

          if
            vim.uv.fs_stat(path .. "/.luarc.json")
            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
          then
            return
          end

          -- Copy all the runtime path directories, so we can add luv.
          local library = vim.tbl_deep_extend(
            "keep",
            vim.api.nvim_get_runtime_file("", true),
            {}
          )

          table.insert(library, "${3rd}/luv/library")

          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = {
                version = "LuaJIT",
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = library,
              },
            })
        end,

        settings = {
          Lua = {
            hint = { enable = true },
          },
        },
      }

      lsp.rust_analyzer.setup {
        capabilities = capabilities,
      }

      lsp.clangd.setup {
        capabilities = capabilities,

        settings = {
          clangd = {
            InlayHints = {
              Enabled = true,
              Designators = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
          },
        },
      }

      local ts_hints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }

      lsp.ts_ls.setup {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = ts_hints,
          },
          javascript = {
            inlayHints = ts_hints,
          },
        },
      }

      lsp.move.setup {
        capabilities = capabilities,
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-rust" {
            dap_adapter = "codelldb",
          },
        },
      }
    end,
    keys = {
      {
        "<leader>cc",
        function() require("neotest").run.run(vim.fn.expand "%") end,
        desc = "[C]heck [c]urrent file (neotest)",
      },
      {
        "<leader>cd",
        function() require("neotest").run.run { strategy = "dap" } end,
        desc = "[C]heck nearest test: [d]ebug (neotest)",
      },
      {
        "<leader>cr",
        function() require("neotest").run.run() end,
        desc = "[C]heck nearest est: [r]un (neotest)",
      },
      {
        "<leader>cu",
        function() require("neotest").run.stop() end,
        desc = "Stop the nearest test (neotest)",
      },
      {
        "<leader>cs",
        function() require("neotest").summary.toggle() end,
        desc = "[C]heck [s]ummary (neotest)",
      },
    },
  },
  {
    "petertriho/cmp-git",
    version = "*",
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    version = "*",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    lazy = false,
    config = function()
      local dap = require "dap"
      local ui = require "dapui"
      local registry = require "mason-registry"

      ui.setup()

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = registry.get_package("codelldb"):get_install_path()
            .. "/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Rust: Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/target/debug/",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
        },
      }

      -- Automatically start/stop the UI when debugging starts
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "[D]ebug toggle [b]reakpoint (DAP)",
      },
      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "[D]ebug [c]ontinue (DAP)",
      },
      {
        "<leader>de",
        function() require("dapui").eval(nil, { enter = true }) end,
        desc = "[D]ebug [e]val (DAP)",
      },
      {
        "<leader>di",
        function() require("dap").step_into() end,
        desc = "[D]ebug step [i]nto (DAP)",
      },
      {
        "<leader>do",
        function() require("dap").step_over() end,
        desc = "[D]ebug step [o]ver (DAP)",
      },
      {
        "<leader>dO",
        function() require("dap").step_out() end,
        desc = "[D]ebug step [o]ut (DAP)",
      },
      {
        "<leader>dr",
        function() require("dap").run_to_cursor() end,
        desc = "[D]ebug [r]un to cursor (DAP)",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        clojure = { "cljfmt" },
        javascript = { "prettier" },
        lua = { "stylua" },
        move = { "prettier-move" },
        python = { "black" },
        rust = { "rustfmt" },
        typescript = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        cljfmt = {
          command = "cljfmt",
          args = { "fix", "$FILENAME" },
          stdin = false,
        },
        ["prettier-move"] = {
          command = "prettier-move",
          args = { "--stdin-filepath", "$FILENAME" },
          range_args = function(_, ctx)
            local util = require "conform.util"
            local lo, hi = util.get_offsets_from_range(ctx.buf, ctx.range)
            return {
              "--stdin-filepath",
              "$FILENAME",
              "--range-start=" .. lo,
              "--range-end=" .. hi,
            }
          end,
        },
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    version = "*",
    opts = {
      virt_text_pos = "eol",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      automatic_installation = true,
    },
  },
  {
    "williamboman/mason.nvim",
    version = "*",
    opts = {},
  },
}
