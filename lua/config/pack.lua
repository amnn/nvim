local github = require("config.packages").github

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
local lazy_specs = {}

for _, category in ipairs(categories) do
  vim.list_extend(packages, category.packages)
  vim.list_extend(lazy_specs, category.lazy or {})
end

local lazy_names = {}
for _, spec in ipairs(lazy_specs) do
  lazy_names[spec[1]] = true
end

local native_packages = {}
local lazy_packages = {}
for _, spec in ipairs(packages) do
  local target = lazy_names[spec.name] and lazy_packages or native_packages
  table.insert(target, spec)
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

vim.pack.add({ github("lumen-oss/lz.n", vim.version.range "3") }, {
  confirm = false,
})
vim.pack.add(native_packages, { confirm = false })
vim.pack.add(lazy_packages, {
  confirm = false,
  load = function() end,
})

for _, category in ipairs(categories) do
  if category.configure then category.configure() end
end

require("lz.n").load(lazy_specs)
