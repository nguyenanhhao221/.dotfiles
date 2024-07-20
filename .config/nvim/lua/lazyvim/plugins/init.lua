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

  --Harpoon to navigate files by ThePrimeagen
  --TODO: Try new branch for harpoon 2.0
  {
    "theprimeagen/harpoon",
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Add file to Harpoon" },
      { "<leader>e", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle Harpoon menu" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end , desc = "Harpoon 1"},
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end,desc="Harpoon 2"},
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end , desc="Harpoon 3"},
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end , desc="Harpoon 4"},
      { "<leader>hn", function() require("harpoon.ui").nav_next() end , desc="Harpoon Nav Next"},
      { "<leader>hp", function() require("harpoon.ui").nav_prev() end , desc="Harpoon Nav Previous"}
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

  --Use `gc` to comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    enabled = false,
    config = true,
  },
  -- TODO comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
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
  { "tpope/vim-sleuth", event = "VeryLazy", enabled = false },
  --Navigate between window easier, work with tmux and nvim
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  --Which key when press
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader>q"] = { name = "+quit" },
      },
    },
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
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
  {
    dir = "/Users/haonguyen/Code/Lua/stackmap.nvim",
    enabled = false,
    event = "VeryLazy",
  },
  -- {
  --   dir = "/Users/haonguyen/Code/Lua/ConsoleTurbo.nvim",
  --   enabled = true,
  -- },
  {
    "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>tp", "<Plug>PlenaryTestFile", { noremap = false, silent = false })
    end,
  },

  -- Screenshot code
  {
    "mistricky/codesnap.nvim",
    cmd = "CodeSnap",
    build = "make",
    opts = {
      code_font_family = "JetBrainsMono NFM",
      mac_window_bar = false,
      has_breadcrumbs = true,
      watermark = "",
    },
  },
  -- {
  --   "michaelrommel/nvim-silicon",
  --   lazy = true,
  --   cmd = "Silicon",
  --   opts = {
  --     -- the font settings with size and fallback font
  --     font = "JetBrainsMono NFM=34;Menlo",
  --     -- the theme to use, depends on themes available to silicon
  --     theme = "Catppuccin-mocha",
  --     -- the background color outside the rendered os window
  --     background = "#FFD1DC",
  --     -- a path to a background image
  --     background_image = nil,
  --     -- the paddings to either side
  --     pad_horiz = 100,
  --     pad_vert = 80,
  --     -- whether to have the os window rendered with rounded corners
  --     no_round_corner = false,
  --     -- whether to put the close, minimize, maximise traffic light controls on the border
  --     no_window_controls = true,
  --     -- whether to turn off the line numbers
  --     no_line_number = true,
  --     -- with which number the line numbering shall start, the default is 1, but here a
  --     -- function is used to return the actual source code line number
  --     line_offset = function(args)
  --       return args.line1
  --     end,
  --     -- the distance between lines of code
  --     line_pad = 2,
  --     -- the rendering of tab characters as so many space characters
  --     tab_width = 4,
  --     -- with which language the syntax highlighting shall be done, should be a function
  --     -- that returns either a language name or an extension like ".js"
  --     language = function()
  --       return vim.bo.filetype
  --     end,
  --     -- if the shadow below the os window should have be blurred
  --     shadow_blur_radius = 16,
  --     -- the offset of the shadow in x and y directions
  --     shadow_offset_x = 8,
  --     shadow_offset_y = 8,
  --     -- the color of the shadow
  --     shadow_color = "#100808",
  --     -- whether to strip of superfluous leading whitespace
  --     gobble = true,
  --     -- a string or function that defines the path to the output image
  --     output = function()
  --       return "./" .. os.date("!%y-%m-%dt%h-%m-%s") .. "_code.png"
  --     end,
  --     -- whether to put the image onto the clipboard, may produce an error if run on WSL2
  --     to_clipboard = true,
  --     -- the silicon command, put an absolute location here, if the command is not in your PATH
  --     command = "silicon",
  --     -- a string or function returning a string that defines the title showing in the image
  --     -- only works in silicon versions greater than v0.5.1
  --     window_title = function()
  --       return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
  --     end,
  --   },
  -- },
}
