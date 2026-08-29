local M = {}

function M.github(repository, version, name)
  return {
    src = "https://github.com/" .. repository,
    name = name or repository:match "([^/]+)$",
    version = version,
  }
end

return M
