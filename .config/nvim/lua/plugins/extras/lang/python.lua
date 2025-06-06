return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              disableLanguageServices = false,
              analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
              },
            },
          },
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        },
        -- pyrefly = {
        -- cmd = { "pyrefly", "lsp" },
        -- filetypes = { "python" },
        -- root_dir = function(fname)
        --   return require("nvim-lspconfig").util.find_git_ancestor(fname) or vim.loop.os_homedir()
        -- end,
        -- settings = {},
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
