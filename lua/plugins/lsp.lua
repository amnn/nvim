local github = require("config.packages").github

return {
  packages = {
    github(
      "amnn/lsp-echohint.nvim",
      "650b3920b9ede5ea002a08661d00501e4d305766"
    ),
    github("saghen/blink.cmp", "78336bc89ee5365633bcf754d93df01678b5c08f"),
    github("j-hui/fidget.nvim", "e1a07a5e46fb65a45a0c76870140bd2d16a73ebf"),
    github("neovim/nvim-lspconfig", "b89138d9af0a96e6048e202a15765fc6b6416bd4"),
    github("stevearc/conform.nvim", "3543d000dafbc41cc7761d860cfdb24e82154f75"),
    github(
      "williamboman/mason-lspconfig.nvim",
      "a5671269a1ddfa7790cdf97c14e600e269da550f"
    ),
    github(
      "williamboman/mason.nvim",
      "2a6940af80375532e5e9e7c1f2fc6319a1b7a69d"
    ),
  },
  configure = function()
    require("mason").setup {}
    require("mason-lspconfig").setup {
      automatic_enable = false,
    }

    require("lsp-echohint").setup {}
    require("blink.cmp").setup {
      keymap = { preset = "default" },
      completion = {
        documentation = { auto_show = true },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
      },
      signature = { enabled = true },
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        sources = { "buffer", "cmdline" },
      },
    }

    require("fidget").setup {
      notification = {
        window = {},
      },
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities({
      workspace = {
        didChangeWatchedFiles = {
          -- Disable workspace/didChangeWatchedFiles. It causes issues in
          -- large projects, where the file watcher opens too many files.
          dynamicRegistration = false,
        },
      },
    }, true)

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = {
        gopls = {
          usePlaceholders = true,
        },
      },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_init = function(client)
        local path = client.workspace_folders[1].name

        if
          vim.uv.fs_stat(path .. "/.luarc.json")
          or vim.uv.fs_stat(path .. "/.luarc.jsonc")
        then
          return
        end

        -- Index Lua roots rather than whole plugin directories. Otherwise,
        -- test monkey-patches can be mistaken for API overloads.
        local library = vim.tbl_deep_extend(
          "keep",
          vim.api.nvim_get_runtime_file("lua", true),
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
          completion = {
            callSnippet = "Replace",
          },
          hint = { enable = true },
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            targetDir = "target/rust-analyzer",
          },
        },
      },
    })

    vim.lsp.config("clangd", {
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
    })

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

    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
        typescript = {
          inlayHints = ts_hints,
        },
        javascript = {
          inlayHints = ts_hints,
        },
      },
    })

    vim.lsp.config("move_analyzer", {
      capabilities = capabilities,
    })

    vim.lsp.config("tinymist", {
      capabilities = capabilities,
      settings = {
        formatterMode = "typstyle",
        formatterPrintWidth = 88,
        formatterProseWrap = false,
      },
    })

    vim.lsp.config("zls", {
      capabilities = capabilities,
    })

    vim.lsp.enable "gopls"
    vim.lsp.enable "lua_ls"
    vim.lsp.enable "rust_analyzer"
    vim.lsp.enable "clangd"
    vim.lsp.enable "ts_ls"
    vim.lsp.enable "move_analyzer"
    vim.lsp.enable "tinymist"
    vim.lsp.enable "zls"

    require("conform").setup {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        clojure = { "cljfmt" },
        go = { "gofmt" },
        javascript = { "prettier" },
        lua = { "stylua" },
        move = { "prettier-move" },
        python = { "black" },
        rust = { "rustfmt" },
        swift = { "swift" },
        typescript = { "prettier" },
        typst = { "typstyle" },
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
    }
  end,
}
