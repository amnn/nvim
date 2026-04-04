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
    config = function(_, opts)
      require("render-markdown").setup(opts)

      local cycle = { "[ ]", "[/]", "[x]" }
      local pattern = "^(%s*)([^%[%s]+%s+)(%[[^%]]%])(.*)$"

      local function find_checkbox(buf, cursor)
        local ok, node = pcall(vim.treesitter.get_node, {
          bufnr = buf,
          pos = { cursor[1] - 1, cursor[2] },
          lang = "markdown",
        })

        if not ok then return nil end
        while node and node:type() ~= "list_item" do
          node = node:parent()
        end

        if not node then return nil end

        local start = node:range()
        local line = vim.api.nvim_buf_get_lines(buf, start, start + 1, false)[1]

        if not line then return nil end

        local indent, marker, state, text = line:match(pattern)
        if not indent then return nil end
        return start, indent, marker, state, text
      end

      local function set_checkbox(state)
        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line, indent, marker, _, text = find_checkbox(bufnr, cursor)
        if not line then return end

        local updated = table.concat { indent, marker, state, text }

        vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { updated })
        vim.api.nvim_win_set_cursor(0, cursor)
      end

      local function cycle_checkbox()
        local bufnr = vim.api.nvim_get_current_buf()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line, indent, marker, state, text = find_checkbox(bufnr, cursor)
        if not line then return end

        local curr = vim.fn.index(cycle, state)
        local next = cycle[(curr + 1) % #cycle + 1]
        local updated = table.concat { indent, marker, next, text }

        vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { updated })
        vim.api.nvim_win_set_cursor(0, cursor)
      end

      local function dispatch_action()
        local action = vim.fn.getcharstr()

        if action == "d" then
          set_checkbox "[x]"
        elseif action == "x" then
          set_checkbox "[-]"
        elseif action == "w" then
          set_checkbox "[^]"
        elseif action == "i" then
          set_checkbox "[!]"
        else
          while action == "c" do
            cycle_checkbox()
            action = vim.fn.getcharstr(0)
            if action == "" then return end
          end

          vim.api.nvim_feedkeys(vim.keycode(action), "n", false)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.keymap.set("n", "<LocalLeader>c", dispatch_action, {
            buffer = event.buf,
            desc = "[C]heckbox",
            silent = true,
          })
        end,
      })
    end,
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
