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

  -- correctly setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       ---@type lspconfig.options.tsserver
  --       tsserver = {
  --         keys = {
  --           { "<leader>oi", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
  --           { "<leader>rf", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
  --           { "<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", desc = "[R]emove unused [T]ypescript" },
  --         },
  --         settings = {
  --           javascript = {
  --             inlayHints = {
  --               includeInlayEnumMemberValueHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --             },
  --           },
  --           typescript = {
  --             inlayHints = {
  --               includeInlayEnumMemberValueHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --             },
  --           },
  --           completions = {
  --             completeFunctionCalls = true,
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       tsserver = function(_, opts)
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --     },
  --   },
  -- },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-vitest")({}))
    end,
  },
}
