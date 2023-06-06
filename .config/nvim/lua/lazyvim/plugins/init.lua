return {
  {
    --Auto closing tag and pairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    lazy = true,
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

  { "nvim-treesitter/playground", lazy = true },

  --Harpoon to navigate files by ThePrimeagen
  {
    "theprimeagen/harpoon",
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
      { "<leader>e", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
      { "<leader>]", function() require("harpoon.ui").nav_file(1) end , desc = "Harpoon 1"},
      { "<leader>[", function() require("harpoon.ui").nav_file(2) end,desc="Harpoon 2"},
      { "<leader>>", function() require("harpoon.ui").nav_file(3) end , desc="Harpoon 3"},
      { "<leader><", function() require("harpoon.ui").nav_file(4) end , desc="Harpoon 4"}
    },
    config = true,
  },

  --Undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = "<leader><F5>",
    config = function()
      vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
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
    event = "VeryLazy",
    config = true,
  },
  -- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
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
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
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
  -- {
  --   dir = "/Users/haonguyen/Code/Lua/stackmap.nvim",
  --   enabled = false,
  -- },
  {
    "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>t", "<Plug>PlenaryTestFile", { noremap = false, silent = false })
    end,
  },
}
