return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- basedpyright = {
        --   settings = {
        --     basedpyright = {
        --       disableOrganizeImports = true,
        --       disableLanguageServices = false,
        --       analysis = {
        --         autoImportCompletions = true,
        --         autoSearchPaths = true,
        --         diagnosticMode = "openFilesOnly",
        --         useLibraryCodeForTypes = true,
        --       },
        --     },
        --   },
        --   on_attach = function(client)
        --     client.server_capabilities.semanticTokensProvider = nil
        --   end,
        -- },
        pyrefly = {
          settings = {},
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        -- Ty, fast rust LSP. Disable for now as it still lack auto import like basedpyright
        -- ty = {
        --   on_attach = function(client)
        --     client.server_capabilities.semanticTokensProvider = nil
        --   end,
        --   settings = {
        --     ty = {
        --       experimental = {
        --         autoImport = true,
        --         rename = true,
        --       },
        --     },
        --   },
        -- },
        ruff = {
          -- disable ruff as hover provider to avoid conflicts with pyright
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = {},
              organizeImports = true,
            },
          },
        },
      },
    },
  },
  -- For Python test
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-python" },
    },
    lazy = true,
    ft = { "python" },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
          dap = {
            justMyCode = true,
            console = "integratedTerminal",
          },
          -- args = { "--log-level", "DEBUG", "-s" },
          -- extra_args = { "--log-level", "DEBUG", "-s" },
          runner = "pytest",
          pytest_discover_instances = false,
        },
      },
    },
  },

  -- select virtual environments
  -- - makes pyright and debugpy aware of the selected virtual environment
  -- - Select a virtual environment with `:VenvSelect`
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false,
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    cmd = { "VenvSelect" },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    opts = {
      dap_enabled = true, -- makes the debugger work with venv
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    },
  },
  -- DAP for Python
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class" },
      },
      ft = { "python" },
      config = function()
        local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
        local dap = require("dap")
        -- dap.configurations.python = {
        --   {
        --     name = "Python: Module",
        --     type = "python",
        --     module = "datamimic",
        --     request = "launch",
        --     justMyCode = true,
        --   },
        -- }
        require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
        require("dap.ext.vscode").load_launchjs(nil)
      end,
    },
  },
}
