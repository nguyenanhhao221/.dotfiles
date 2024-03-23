local Format = require("lazyvim.plugins.lsp.format")
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
      notify_on_error = true,
      formatters = {
        -- ruff_format = {
        --   -- Change where to find the command
        --   command = "./venv/bin/ruff",
        -- },
        black = {
          -- Change where to find the command
          command = "./venv/bin/black",
        },
        isort = {
          -- Change where to find the command
          command = "./venv/bin/isort",
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = {
          "isort",
          -- "ruff_format",
          "black",
        },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        vue = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        go = { "goimports", "gofmt" },
        c = { "clang_format" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if Format.autoformat then
          return { timeout_ms = 500, lsp_fallback = false, async = true }
        end
      end,
    },
  },
}
