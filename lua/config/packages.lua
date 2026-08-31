local M = {}

-- Add a package, to be installed and loaded eagerly.
function M.eager(specs) return vim.pack.add(specs, { confirm = false }) end

-- Add a package, to be installed and loaded lazily. Lazy loading must be
-- configured separately, using `lz.n`.
function M.lazy(specs)
  return vim.pack.add(specs, { confirm = false, load = function() end })
end

function M.github(repository, version, name)
  return {
    src = "https://github.com/" .. repository,
    name = name or repository:match "([^/]+)$",
    version = version,
  }
end

return M
