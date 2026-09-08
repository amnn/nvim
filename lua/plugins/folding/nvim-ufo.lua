require("lz.n").load {
  {
    "nvim-ufo",
    event = "DeferredUIEnter",
    keys = {
      {
        "zR",
        function() require("ufo").openAllFolds() end,
        desc = "Open all folds (UFO)",
      },
      {
        "zM",
        function() require("ufo").closeAllFolds() end,
        desc = "Close all folds (UFO)",
      },
      {
        "zr",
        function() require("ufo").openFoldsExceptKinds() end,
        desc = "Open folds except configured kinds (UFO)",
      },
      {
        "zm",
        function() require("ufo").closeFoldsWith() end,
        desc = "Close folds by level (UFO)",
      },
      {
        "zK",
        function() require("ufo").peekFoldedLinesUnderCursor() end,
        desc = "Preview folded lines (UFO)",
      },
    },
    after = function()
      require("ufo").setup {
        provider_selector = function(_, _) return { "treesitter", "indent" } end,
      }
    end,
  },
}
