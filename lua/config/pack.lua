local group = vim.api.nvim_create_augroup("pack_hooks", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
  group = group,
  callback = function(event)
    local n = event.data.spec.name
    local k = event.data.kind

    if n == "nvim-treesitter" and (k == "install" or k == "update") then
      vim.schedule(function()
        local ok, treesitter = pcall(require, "nvim-treesitter")
        if ok then treesitter.update() end
      end)
    end
  end,
})

require "plugins.lz"

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
