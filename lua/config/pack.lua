local category_names = {
  "plugins.theming",
  "plugins.treesitter",
  "plugins.picker",
  "plugins.text",
  "plugins.window",
  "plugins.vc",
  "plugins.ai",
  "plugins.lsp",
  "plugins.rust",
  "plugins.markdown",
}

local categories = vim.tbl_map(require, category_names)
local packages = {}

for _, category in ipairs(categories) do
  vim.list_extend(packages, category.packages)
end

local group = vim.api.nvim_create_augroup("pack_hooks", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
  group = group,
  callback = function(event)
    if
      event.data.spec.name ~= "nvim-treesitter"
      or (event.data.kind ~= "install" and event.data.kind ~= "update")
    then
      return
    end

    vim.schedule(function()
      local ok, treesitter = pcall(require, "nvim-treesitter")
      if ok then treesitter.update() end
    end)
  end,
})

vim.pack.add(packages, { confirm = false })

for _, category in ipairs(categories) do
  if category.configure then category.configure() end
end
