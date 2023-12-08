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
      notify_on_error = false,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = {
          "isort",
          "black",
          -- "ruff_format",
        },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        vue = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if Format.autoformat then
          return { timeout_ms = 500, lsp_fallback = true, async = true }
        end
      end,
    },
  },
}
