-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Add vscode like icon
      "onsails/lspkind.nvim",

      "hrsh7th/cmp-nvim-lsp",
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        opts = {},
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
        float = {
          border = "rounded",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("config").icons.diagnostics.ERROR,
            [vim.diagnostic.severity.WARN] = require("config").icons.diagnostics.WARN,
            [vim.diagnostic.severity.HINT] = require("config").icons.diagnostics.HINT,
            [vim.diagnostic.severity.INFO] = require("config").icons.diagnostics.INFO,
          },
        },
      },
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
      },
    },
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
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local servers = opts.servers
      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
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
          winblend = 0, -- Background color opacity in the notification window
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
