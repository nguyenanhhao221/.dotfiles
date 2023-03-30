return {
  -- formatting & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local formatting = require("null-ls").builtins.formatting -- to setup formatters
      local diagnostics = require("null-ls").builtins.diagnostics -- to setup linters
      -- to setup format on save
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      -- configure null_ls
      require("null-ls").setup({
        -- setup formatters & linters
        sources = {
          --  to disable file types use
          formatting.prettierd.with({
            disabled_filetypes = { "yml", "yaml" },
          }),
          formatting.stylua, -- lua formatter
          formatting.black, -- python formatter
          -- diagnostics.eslint.with({ -- js/ts linter
          --   -- only enable eslint if root has .eslintrc.json (not in youtube nvim video)
          --   condition = function(utils)
          --     -- change file extension if you use something else
          --     return utils.root_has_file({ "./ui/.eslintrc.json" })
          --   end,
          -- }),
        },
        -- configure format on save
        on_attach = function(current_client, bufnr)
          if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    --  only use null-ls for formatting instead of lsp server
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                })
              end,
            })
          end
        end,
      })
    end,
  }, -- configure formatters & linters
  {
    "jayp0521/mason-null-ls.nvim",
    dependencies = { "jose-elias-alvarez/null-ls.nvim" },
    enabled = true,
    event = "VeryLazy", -- bridges gap b/w mason & null-ls
    opts = {
      -- list of formatters & linters for mason to install
      ensure_installed = {
        -- "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        -- "eslint", -- ts/js linter
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    },
  },
}
