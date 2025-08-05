-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "mason-org/mason.nvim", config = true, cmd = "Mason" }, -- NOTE: Must be loaded before dependents
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {},
      },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = true,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            -- Only show virtual_text minimum severity is WARN
            severity = { min = vim.diagnostic.severity.WARN },
          },
          severity_sort = true,
          float = {
            border = "rounded",
          },
          -- signs = {
          --   text = {
          --     [vim.diagnostic.severity.ERROR] = require("config").icons.diagnostics.ERROR,
          --     [vim.diagnostic.severity.WARN] = require("config").icons.diagnostics.WARN,
          --     [vim.diagnostic.severity.HINT] = require("config").icons.diagnostics.HINT,
          --     [vim.diagnostic.severity.INFO] = require("config").icons.diagnostics.INFO,
          --   },
          -- },
        },
        ---@type lspconfig.options
        servers = {
          -- clangd = {},
          jsonls = {
            -- lazy-load schemastore when needed
            on_new_config = function(new_config)
              new_config.settings.json.schemas = new_config.settings.json.schemas or {}
              vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = {
              json = {
                format = {
                  enable = true,
                },
                validate = { enable = true },
              },
            },
          },
          dockerls = {},
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
                diagnostics = {
                  globals = { "vim" },
                  -- ignore Lua_LS's noisy `missing-fields` warnings
                  disable = { "missing-fields" },
                },
                hint = {
                  enable = true,
                },
              },
            },
          },
          html = {},
          cssls = {},
          tailwindcss = {},
          emmet_ls = {
            filetypes = {
              "html",
              "typescriptreact",
              "javascriptreact",
              "css",
              "sass",
              "scss",
              "less",
              "svelte",
            },
          },
          -- third party gitlab lsp
          gitlab_ci_ls = {},
        },
      }
      return ret
    end,
    config = function(_, opts)
      local Util = require("util")
      Util.on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- Set up diagnostics config
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
      capabilities = vim.tbl_deep_extend("force", capabilities, {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local servers = opts.servers
      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        "sqlfluff", -- Format sql
      })

      -- Loop through all servers and set them up with their configurations
      for server_name, server_settings in pairs(servers) do
        -- Merge default capabilities with any server-specific settings
        local final_settings = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
        }, server_settings)
        vim.lsp.config(server_name, final_settings)
        vim.lsp.enable(server_name)
      end
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      -- Options related to notification subsystem
      notification = {
        -- Options related to the notification window and buffer
        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          -- for transparent background set up
          winblend = 100, -- Background color opacity in the notification window
          border = "none", -- Border around the notification window
          zindex = 45, -- Stacking priority of the notification window
          max_width = 0, -- Maximum width of the notification window
          max_height = 0, -- Maximum height of the notification window
          x_padding = 1, -- Padding from right edge of window boundary
          y_padding = 0, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
        },
      },
    },
  },
  {
    "b0o/SchemaStore.nvim",
    version = false, -- last release is way too old
    lazy = true,
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
}
