local Format = require("plugins.lsp.format")
local PythonUtil = require("util.python")

---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end
return {

  {
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<C-f>",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      formatters = {
        ruff_format = {
          command = PythonUtil.get_venv_command("ruff"),
        },
        black = {
          command = PythonUtil.get_venv_command("black"),
        },
        isort = {
          command = PythonUtil.get_venv_command("isort"),
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Run the first available formatter followed by more formatters
        -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#run-the-first-available-formatter-followed-by-more-formatters
        python = function(bufnr)
          return { "isort", first(bufnr, "ruff_format", "black") }
        end,
        -- Use a sub-list to run only the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        vue = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofmt" },
        c = { "clang_format" },
        rust = { "rustfmt" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if Format.autoformat then
          return { timeout_ms = 500, lsp_fallback = false }
        end
      end,
    },
  },
}
