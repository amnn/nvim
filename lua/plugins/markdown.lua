return {
  {
    "3rd/image.nvim",
    build = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = {
          clear_in_insert_mode = false,
          download_remote_images = false,
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = true,
          filetypes = { "markdown" },
        },
      },
      scale_factor = 1.0,
      max_height_window_percentage = 40,
      window_overlap_clear_enabled = true,
      editor_only_render_when_focused = true,
      tmux_show_only_in_active_window = true,
      hijack_file_patterns = {
        "*.png",
        "*.jpg",
        "*.jpeg",
        "*.gif",
        "*.webp",
        "*.avif",
        "*.svg",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "3rd/image.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      checkbox = {
        enabled = true,
        bullet = false,
        right_pad = 1,
        unchecked = {
          icon = "☐",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "⊡",
          highlight = "RenderMarkdownChecked",
          scope_highlight = "RenderMarkdownChecked",
        },
        custom = {
          incomplete = {
            raw = "[/]",
            rendered = "◩",
            highlight = "DiagnosticInfo",
            scope_highlight = "DiagnosticInfo",
          },
          canceled = {
            raw = "[-]",
            rendered = "⊟",
            highlight = "Comment",
            scope_highlight = "DiagnosticDeprecated",
          },
          important = {
            raw = "[!]",
            rendered = "◆",
            highlight = "Title",
            scope_highlight = "Title",
          },
          blocked = {
            raw = "[^]",
            rendered = "▨",
            highlight = "DiagnosticWarn",
            scope_highlight = "DiagnosticWarn",
          },
        },
      },
      code = {
        border = "thin",
        language_icon = false,
        language_name = false,
        left_pad = 2,
        right_pad = 2,
        inline_pad = 1,
        width = "block",
      },
      completions = { lsp = { enabled = true } },
      heading = {
        icons = { "󰼏 ", "󰎨 ", "󰼑 ", "󰎲 ", "󰼓 ", "󰎴 " },
      },
      pipe_table = {
        alignment_indicator = "┅",
        style = "normal",
      },
    },
  },
}
