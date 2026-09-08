local p = require "config.packages"

local function setup()
  require("image").setup {
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
  }

  local processor = require "image/processors/magick_cli"
  local convert_to_png = processor.convert_to_png
  local resize = processor.resize
  local magick = vim.fn.executable "magick" == 1 and "magick" or "convert"

  processor.convert_to_png = function(path, output_path)
    if
      vim.fn.executable "rsvg-convert" == 1
      and processor.get_format(path) == "svg"
    then
      local out_path = output_path or path:gsub("%.[^.]+$", ".png")
      local result = vim
        .system({
          "rsvg-convert",
          "--format",
          "png",
          "--zoom",
          "4",
          "--output",
          out_path,
          path,
        })
        :wait(10000)

      if result.code ~= 0 then
        error(
          result.stderr ~= "" and result.stderr or "Failed to convert to PNG"
        )
      end

      return out_path
    end

    return convert_to_png(path, output_path)
  end

  processor.resize = function(path, width, height, output_path)
    local out_path = output_path or path:gsub("%.([^.]+)$", "-resized.%1")
    local result = vim
      .system({
        magick,
        path,
        "-filter",
        "Lanczos",
        "-resize",
        string.format("%dx%d", width, height),
        out_path,
      })
      :wait(10000)

    if result.code ~= 0 then
      error(result.stderr ~= "" and result.stderr or "Failed to resize")
    end

    return out_path
  end
end

p.lazy { p.github "3rd/image.nvim" }

require("lz.n").load {
  {
    "image.nvim",
    ft = "markdown",
    event = {
      {
        event = { "BufReadPre", "BufNewFile" },
        pattern = {
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
    after = setup,
  },
}
