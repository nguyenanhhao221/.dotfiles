-- LSP Configuration & Plugins
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Additional lua configuration, makes nvim stuff amazing
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        opts = {
          experimental = { pathStrict = true },
          library = { plugins = { "nvim-dap-ui" }, types = true },
        },
      },
      -- Typescript enhance for lsp
      "jose-elias-alvarez/typescript.nvim",
      -- Add vscode like icon
      "onsails/lspkind.nvim",
      --Enhance lsp UI
      "glepnir/lspsaga.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      --  Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  Add any additional override configuration in the following tables. They will be passed to
      ---@type lspconfig.options
      servers = {
        -- clangd = {},
        -- gopls = {},
        jsonls = {},
        pylsp = {
          -- For debugging
          -- cmd = { os.getenv("HOME") .. "/.config/nvim/venv/bin/pylsp", "--log-file=/tmp/pylsp.log", "-v" },
          settings = {
            pylsp = {
              configurationSources = { "flake8" },
              plugins = {
                flake8 = {
                  enabled = true,
                },
                pycodestyle = {
                  enabled = false,
                },
                mccabe = {
                  enabled = false,
                },
                pyflakes = {
                  enabled = false,
                },
                pylint = {
                  enabled = true,
                  executable = "venv/bin",
                },
              },
            },
          },
        },
        pyright = {},
        -- rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        -- efm = {
        --   filetypes = { "python", "cpp", "lua" },
        -- },
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
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        --
        -- Remap for lsp related
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        -- Hover docs
        -- nmap("<leader>k", ":Lspsaga hover_doc<CR>", "Hover Docs")
        nmap("<leader>k", vim.lsp.buf.hover, "Hover Docs")
        -- Code action
        nmap("<leader>ca", ":Lspsaga code_action<CR>", "[c]ode [a]ction")
        -- Go to definition
        nmap("gd", vim.lsp.buf.definition, "Peek [G]o [D]efinition")
        -- Type definition
        nmap("<leader>gt", ":Lspsaga peek_type_definition<CR>", "Peek [T]ype [D]efinition")

        --lsp finder toogle
        nmap("<leader>lf", ":Lspsaga lsp_finder<CR>", "[l]sp [f]inder")
        -- show  diagnostics for line
        nmap("<leader>D", ":Lspsaga show_line_diagnostics<CR>", "Show Line diagnostics")
        -- show diagnostics for cursor
        nmap("<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics")
        -- jump to previous diagnostic in buffer
        nmap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "jump to previous diagnostic in buffer")
        -- jump to next diagnostic in buffer
        nmap("]d", ":Lspsaga diagnostic_jump_next<CR>", "jump to next diagnostic in buffer")
        nmap("<leader>rn", ":Lspsaga rename<CR>", "[R]e[n]ame")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("<leader>sh", vim.lsp.buf.signature_help, "Signature Documentation")

        nmap("gr", "<cmd>Telescope lsp_references<cr>", "References")
        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        nmap("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        -- typescript specific keymaps (e.g. rename file and update imports)
        if client.name == "tsserver" then
          -- rename file and update imports
          nmap("<leader>rf", ":TypescriptRenameFile<CR>", "[R]ename [F]ile Typescript")
          -- organize imports (not in youtube nvim video)
          nmap("<leader>oi", ":TypescriptOrganizeImports<CR>", "[O]rganize [I]mport Typescript")
          -- remove unused variables (not in youtube nvim video)
          nmap("<leader>ru", ":TypescriptRemoveUnused<CR>", "[R]emove unused [T]ypescript")
        end
      end

      local servers = opts.servers
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach,
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available thourgh mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed })
        mlsp.setup_handlers({ setup })
      end
      -- -- enable mason
      -- require("mason").setup()
      --
      -- require("mason-lspconfig").setup({
      --   -- list of servers for mason to install
      --   ensure_installed = vim.tbl_keys(servers),
      --   -- auto-install configured servers (with lspconfig)
      --   automatic_installation = true, -- not the same as ensure_installed
      -- })
      --
      -- require("mason-lspconfig").setup_handlers({
      --   function(server_name)
      --     require("lspconfig")[server_name].setup({
      --       capabilities = capabilities,
      --       on_attach = on_attach,
      --       { servers[server_name] },
      --     })
      --   end,
      -- })

      -- configure typescript server with plugin
      require("typescript").setup({
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
      { "onsails/lspkind.nvim" },
    },
    event = "LspAttach",
    opts = {
      -- keybinds for navigation in lspsaga window
      scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
      },
      outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        show_detail = true,
        auto_preview = false,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
          jump = "o",
          expand_collapse = "u",
          quit = "q",
        },
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = false,
        keys = {
          -- string | table type
          quit = "q",
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
      },
      -- after jump from float window there will show beacon to remind you where the cursor is.
      beacon = {
        enable = true,
        frequency = 7,
      },
    },
  },
}
