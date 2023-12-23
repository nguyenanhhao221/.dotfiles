return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              disableLanguageServices = false,
              disableOrganizeImports = false,
            },
            python = {
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        -- {
        --   jedi_language_server = {},
        -- },
        ruff_lsp = {
          -- disable ruff as hover provider to avoid conflicts with pyright
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = {},
              -- organize imports disabled, since we are already using `isort` for that
              -- alternative, this can be enabled to make `organize imports`
              -- available as code action
              organizeImports = false,
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
          args = { "--log-level", "DEBUG", "-s" },
          -- extra_args = { "--log-level", "DEBUG", "-s" },
          runner = "pytest",
          pytest_discover_instances = true,
        },
      },
    },
  },
  -- select virtual environments
  -- - makes pyright and debugpy aware of the selected virtual environment
  -- - Select a virtual environment with `:VenvSelect`
  {
    "linux-cultist/venv-selector.nvim",
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
}
