local p = require "config.packages"

local filetypes = {
  "c",
  "c.doxygen",
  "cpp",
  "cpp.doxygen",
  "cuda",
  "go",
  "gomod",
  "gotmpl",
  "gowork",
  "javascript",
  "javascriptreact",
  "lua",
  "move",
  "objc",
  "objcpp",
  "rust",
  "typescript",
  "typescriptreact",
  "typst",
  "zig",
  "zir",
}

local function setup()
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
      local library = vim.api.nvim_get_runtime_file("lua", true)
      for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
        local lua_path = vim.fs.joinpath(plugin.path, "lua")
        if vim.uv.fs_stat(lua_path) then table.insert(library, lua_path) end
      end

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
end

p.lazy { p.github("neovim/nvim-lspconfig", vim.version.range "*") }

require("lz.n").load {
  {
    "nvim-lspconfig",
    ft = filetypes,
    before = function()
      require("lz.n").trigger_load { "blink.cmp", "mason.nvim" }
    end,
    after = setup,
  },
}
