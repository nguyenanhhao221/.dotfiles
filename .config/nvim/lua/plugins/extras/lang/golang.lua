return {
  -- Go Lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = false,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              -- semanticTokens = true,
            },
          },
          -- on_attach = function(client)
          --   if client.name == "gopls" and not client.server_capabilities.semanticTokensProvider then
          --     local semantic = client.config.capabilities.textDocument.semanticTokens
          --     client.server_capabilities.semanticTokensProvider = {
          --       full = true,
          --       legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
          --       range = true,
          --     }
          --   end
          -- end,
        },
      },
    },
  },
  -- Go DAP
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    ft = { "go" },
    config = function()
      local dap = require("dap")
      dap.configurations.go = {
        {
          -- Must be "go" or it will be ignored by the plugin
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          name = "Launch Package",
          type = "go",
          request = "launch",
          mode = "auto",
          program = "${fileDirname}",
        },
      }
      require("dap-go").setup()
    end,
  },
  -- For Go test
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Here we can set options for neotest-golang, e.g.
          go_test_args = { "-v" },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
    },
  },
}
