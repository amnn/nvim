---@class Config.TreesitterLanguage
---@field parser string
---@field filetypes? string[] Overrides the default filetype matching the parser name.
---@field context? boolean Whether nvim-treesitter-context supports the language.
---@field parser_config? table<string, any> Custom nvim-treesitter parser metadata.

---@type Config.TreesitterLanguage[]
local languages = {
  { parser = "c" },
  { parser = "clojure" },
  { parser = "fennel" },
  { parser = "fish" },
  { parser = "graphql" },
  { parser = "go" },
  { parser = "gomod", context = false },
  { parser = "gowork", context = false },
  { parser = "lua" },
  { parser = "markdown", filetypes = { "markdown", "pandoc" } },
  { parser = "markdown_inline", filetypes = {}, context = false },
  {
    parser = "move",
    context = false,
    parser_config = {
      install_info = {
        url = "https://github.com/MystenLabs/sui",
        revision = "4ba6c1fe30a78be877812cf6619f4a2534cd496d",
        location = "external-crates/move/tooling/tree-sitter",
        queries = "external-crates/move/tooling/tree-sitter/queries",
      },
      tier = 2,
    },
  },
  { parser = "python", filetypes = { "python", "py", "gyp" } },
  { parser = "rust" },
  { parser = "scheme", context = false },
  { parser = "sql", context = false },
  {
    parser = "tsx",
    filetypes = { "tsx", "typescriptreact", "typescript.tsx" },
  },
  { parser = "typescript", filetypes = { "typescript", "ts" } },
  { parser = "typst", filetypes = { "typst", "typ" } },
  { parser = "vim" },
}

local ensure_installed = {}
local filetypes = {}
local context_filetypes = {}
local parser_configs = {}

for _, language in ipairs(languages) do
  ensure_installed[#ensure_installed + 1] = language.parser

  local language_filetypes = language.filetypes or { language.parser }
  vim.list_extend(filetypes, language_filetypes)

  if language.context ~= false then
    vim.list_extend(context_filetypes, language_filetypes)
  end

  if language.parser_config then
    parser_configs[language.parser] = language.parser_config
  end
end

return {
  languages = languages,
  ensure_installed = ensure_installed,
  filetypes = filetypes,
  context_filetypes = context_filetypes,
  parser_configs = parser_configs,
}
