local eager = require("config.packages").eager
local github = require("config.packages").github

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

eager { github("lumen-oss/lz.n", vim.version.range "3") }

require "plugins.theming"
require "plugins.treesitter"
require "plugins.picker"
require "plugins.text"
require "plugins.window"
require "plugins.vc"
require "plugins.ai"
require "plugins.lsp"
require "plugins.rust"
require "plugins.markdown"
