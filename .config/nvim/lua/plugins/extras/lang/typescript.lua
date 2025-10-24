return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  -- {
  --   "mason-org/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "eslint-lsp" })
  --   end,
  -- },

  -- correctly setup lspconfig
  -- Eslint
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --      eslint = {
  --         settings = {
  --           -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
  --           workingDirectories = { mode = "auto" },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- ts_ls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          settings = {},
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
      },
    },
  },
  -- typescript-tool
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   enabled = true,
  --   ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  --   opts = {
  --     on_attach = function(client)
  --       client.server_capabilities.semanticTokensProvider = nil
  --     end,
  --     settings = {
  --       tsserver_file_preferences = {
  --         includeInlayParameterNameHints = "all",
  --       },
  --     },
  --   },
  -- },
  -- Lingting with eslint_d
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       javascript = { "eslint_d" },
  --       typescript = { "eslint_d" },
  --       vue = { "eslint_d" },
  --       typescriptreact = { "eslint_d" },
  --       javascriptreact = { "eslint_d" },
  --     },
  --   },
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    lazy = true,
    ft = { "typescript", "javascript" },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
  },
}
