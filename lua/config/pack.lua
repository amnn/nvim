local function github(repository, version, name)
  return {
    src = "https://github.com/" .. repository,
    name = name or repository:match "([^/]+)$",
    version = version,
  }
end

local function eager(specs) vim.pack.add(specs, { confirm = false }) end

local function lib(specs) vim.pack.add(specs, { confirm = false, load = false }) end

local function lazy(specs)
  vim.pack.add(specs, { confirm = false, load = function() end })
end

local group = vim.api.nvim_create_augroup("pack_hooks", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
  group = group,
  callback = function(event)
    local n = event.data.spec.name
    local k = event.data.kind

    if n == "nvim-treesitter" and (k == "install" or k == "update") then
      vim.schedule(function()
        local ok, lz = pcall(require, "lz.n")
        if ok then lz.trigger_load "nvim-treesitter" end

        local loaded, treesitter = pcall(require, "nvim-treesitter")
        if loaded then treesitter.update() end
      end)
    end
  end,
})

eager {
  -- Infrastructure
  github("lumen-oss/lz.n", vim.version.range "3"),

  -- Theming
  github("projekt0n/github-nvim-theme", nil, "github-theme"),
  github("cormacrelf/dark-notify", vim.version.range "*"),
}

lib {
  github "nvim-tree/nvim-web-devicons",
  github "nvim-lua/plenary.nvim",
  github "MunifTanjim/nui.nvim",
  github "tpope/vim-repeat",
}

lazy {
  -- Theming
  github "nvim-lualine/lualine.nvim",

  -- Treesitter
  github("nvim-treesitter/nvim-treesitter", "main"),
  github "nvim-treesitter/nvim-treesitter-context",

  -- Pickers and navigation
  github "ahmedkhalf/project.nvim",
  github("folke/which-key.nvim", vim.version.range "*"),
  github "ibhagwan/fzf-lua",
  github("stevearc/oil.nvim", vim.version.range "*"),
  github("stevearc/quicker.nvim", vim.version.range "*"),

  -- Text editing
  github "Grazfather/sexp.nvim",
  github("HiPhish/rainbow-delimiters.nvim", vim.version.range "*"),
  github("cappyzawa/trim.nvim", vim.version.range "*"),
  github("folke/flash.nvim", vim.version.range "*"),
  github("folke/todo-comments.nvim", vim.version.range "*"),
  github("kylechui/nvim-surround", vim.version.range "*"),
  github "m4xshen/autoclose.nvim",

  -- Windows
  github "sindrets/winshift.nvim",

  -- Version control
  github "tpope/vim-fugitive",
  github "tpope/vim-rhubarb",
  github "lewis6991/gitsigns.nvim",
  github "julienvincent/hunk.nvim",

  -- AI
  github("github/copilot.vim", vim.version.range "*"),

  -- Language tooling
  github("williamboman/mason.nvim", vim.version.range "*"),
  github("williamboman/mason-lspconfig.nvim", vim.version.range "*"),
  github("neovim/nvim-lspconfig", vim.version.range "*"),
  github "amnn/lsp-echohint.nvim",
  github("saghen/blink.cmp", vim.version.range "1"),
  github("j-hui/fidget.nvim", vim.version.range "*"),
  github("stevearc/conform.nvim", vim.version.range "*"),

  -- Languages and file types
  github("saecki/crates.nvim", "stable"),
  github "3rd/image.nvim",
  github "MeanderingProgrammer/render-markdown.nvim",
}

-- Configuration modules execute eager setup or register lz.n triggers. Files
-- under lua/ are not sourced automatically from runtimepath.

-- Theming
require "plugins.theming.github-theme"
require "plugins.theming.lualine"
require "plugins.theming.dark-notify"

-- Treesitter
require "plugins.treesitter.nvim-treesitter"
require "plugins.treesitter.nvim-treesitter-context"

-- Pickers and navigation
require "plugins.picker.project"
require "plugins.picker.which-key"
require "plugins.picker.fzf-lua"
require "plugins.picker.oil"
require "plugins.picker.quicker"

-- Text editing
require "plugins.text.sexp"
require "plugins.text.rainbow-delimiters"
require "plugins.text.trim"
require "plugins.text.flash"
require "plugins.text.todo-comments"
require "plugins.text.nvim-surround"
require "plugins.text.autoclose"

-- Windows
require "plugins.window.winshift"

-- Version control
require "plugins.vc.fugitive"
require "plugins.vc.rhubarb"
require "plugins.vc.gitsigns"
require "plugins.vc.hunk"

-- AI
require "plugins.ai.copilot"

-- Language tooling
require "plugins.lsp.mason"
require "plugins.lsp.mason-lspconfig"
require "plugins.lsp.lsp-echohint"
require "plugins.lsp.blink-cmp"
require "plugins.lsp.fidget"
require "plugins.lsp.nvim-lspconfig"
require "plugins.lsp.conform"

-- Languages and file types
require "plugins.rust.crates"
require "plugins.markdown.image"
require "plugins.markdown.render-markdown"
