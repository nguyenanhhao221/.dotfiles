return {
  {
    --Auto closing tag and pairs
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false, -- don't check treesitter on java
      },
    },
    config = function(_, opts)
      -- import nvim-autopairs completion functionality safely
      local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not cmp_autopairs_setup then
        return
      end

      -- import nvim-cmp plugin safely (completions plugin)
      local cmp_setup, cmp = pcall(require, "cmp")
      if not cmp_setup then
        return
      end
      -- make autopairs and completion work together
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      require("nvim-autopairs").setup(opts)
    end,
  },

  -- Theme, there are multiple theme, comment and uncomment which one to use
  -- Tokyonight themes
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    name = "tokyonight",
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
    style = "night",
  },
  --Kanagawa Themes
  {
    "rebelot/kanagawa.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    name = "kanagawa",
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme kanagawa]])
      require("kanagawa").setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true, -- do not set background color
        dimInactive = false, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
          -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus",
        },
      })
    end,
  },
  { "nvim-treesitter/playground", lazy = true },

  --Harpoon to navigate files by ThePrimeagen
  {
    "theprimeagen/harpoon",
    event = "VeryLazy",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "[a]dd file to harpoon" })
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })

      vim.keymap.set("n", "<leader>]", function()
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<leader>[", function()
        ui.nav_file(2)
      end)
      vim.keymap.set("n", "<leader>>", function()
        ui.nav_file(3)
      end)
      vim.keymap.set("n", "<leader><", function()
        ui.nav_file(4)
      end)
    end,
  },

  --Undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = "<leader>u",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = "neovim/nvim-lspconfig",
  },
  --Use `gc` to comment
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "VeryLazy",
    config = true,
  },
  -- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup({})
    end,
  },
  -- Detect tabstop and shiftwidth automatically
  { "tpope/vim-sleuth", event = "VeryLazy" },
  --Navigate between window easier, work with tmux and nvim
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  --Which key when press
  -- Lua
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  --Markdown preview
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  --A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  -- DAP debugging

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      --DAP, Related config and settings for debugging
      local dap_status, dap = pcall(require, "dap")
      if not dap_status then
        return
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = "Debug: " .. desc
        end

        vim.keymap.set("n", keys, func, { desc = desc })
      end

      -- Set keymaps to control the debugger
      nmap("<F5>", dap.continue, "Debug continue")
      nmap("<F10>", dap.step_over, "Debug step over")
      nmap("<F11>", dap.step_into, "Debug step into")
      nmap("<F12>", dap.step_out, "Debug step out")
      nmap("<leader>b", dap.toggle_breakpoint, "Debug set Breakpoint")
      nmap("<leader>B", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, "Breakpoint condition")
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "VeryLazy",
    opts = function()
      -- Javascript debug
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = {
          "chrome",
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
          "node",
          "chrome",
        }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })
    end,
  },
}
