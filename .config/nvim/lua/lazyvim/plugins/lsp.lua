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
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      -- Typescript enhance for lsp
      "jose-elias-alvarez/typescript.nvim",
      -- Add vscode like icon
      "onsails/lspkind.nvim",
      --Enhance lsp UI
      "glepnir/lspsaga.nvim",
    },
    opts = {
      --  Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --  Add any additional override configuration in the following tables. They will be passed to
      servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- tsserver = {},
        rust_analyzer = {},
        lua_ls = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            diagnostics = {
              globals = "vim",
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
      -- Neodev
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup({})

      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.

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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- enable mason
      require("mason").setup()

      require("mason-lspconfig").setup({
        -- list of servers for mason to install
        ensure_installed = vim.tbl_keys(servers),
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      })

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
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
      { "onsails/lspkind.nvim" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      --lspSaga
      require("lspsaga").setup({
        -- keybinds for navigation in lspsaga window
        scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
        -- use enter to open file with definition preview
        definition = {
          edit = "<CR>",
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
      })
    end,
  },
}
