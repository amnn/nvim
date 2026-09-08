require("lz.n").load {
  {
    "project.nvim",
    event = "DeferredUIEnter",
    cmd = { "AddProject", "ProjectRoot" },
    after = function()
      require("project_nvim").setup {
        detection_methods = { "pattern" },
        patterns = { ".git", ".hg", ".project", "Move.toml", "init.lua" },
      }
      require("project_nvim.project").on_buf_enter()
    end,
  },
}
