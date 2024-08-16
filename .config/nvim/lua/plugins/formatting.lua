local Format = require("plugins.lsp.format")
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
          -- Change where to find the command
          command = "./venv/bin/ruff",
        },
        -- black = {
        --   -- Change where to find the command
        --   command = "./venv/bin/black",
        -- },
        isort = {
          -- Change where to find the command
          command = "./venv/bin/isort",
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
