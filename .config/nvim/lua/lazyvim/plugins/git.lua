return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>g"] = { name = "+git" },
        ["<leader>l"] = { name = "+lazygit" },
      },
    },
    optional = true,
  },
  -- Toggle Term to be used with lazygit, lazydockek
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", desc = "Toggle Lazy Git" },
      { "<leader>ld", "<cmd>lua Lazydocker_toggle()<CR>", desc = "Toggle Lazy Docker" },
    },
    config = function()
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "double", -- like `size`, width and height can be a number or function which is passed the current terminal
          width = 1000,
          height = 1000,
          winblend = 3,
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = "double", -- like `size`, width and height can be a number or function which is passed the current terminal
          width = 1000,
          height = 1000,
          winblend = 3,
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function Lazygit_toggle()
        lazygit:toggle()
      end

      function Lazydocker_toggle()
        lazydocker:toggle()
      end
      vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>lua Lazydocker_toggle()<CR>", { noremap = true, silent = true })
    end,
  },
  -- Git related plugins
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "tpope/vim-rhubarb",
    },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "git status" },
      { "<leader>gC", "<cmd>Git commit<CR>", desc = "git commit", silent = false },
      {
        "ga",
        "<cmd>diffget //2<CR>",
        desc = "git get left",
      },
      {
        "gk",
        "<cmd>diffget //3<CR>",
        desc = "git get right",
      },
    },
    cmd = { "Git" },
    config = function()
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "[g]it [s]tatus" })
    end,
  },
  {
    "tpope/vim-rhubarb",
    lazy = true,
  },
  -- Intergrate with gh cli, review PR without leaving terminal
  {
    "ldelossa/gh.nvim",
    dependencies = { { "ldelossa/litee.nvim" } },
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("litee.lib").setup()
      require("litee.gh").setup({})
    end,
  },
  -- Octos for github
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  {
    "harrisoncramer/gitlab.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    dir = "/Users/haonguyen/Code/neovim-projects/gitlab-nvim", -- Pass in the path to your cloned repository
    opts = {
      -- Point to my local .gitlab.nvim path which is ignore by git to avoid expose token
      -- As of today need to have auth for rapiddweller gitlab
      config_path = "/Users/haonguyen/.dotfiles/.config/", -- Custom path for `.gitlab.nvim` file, please read the "Connecting to Gitlab" section
    },
    -- stylua: ignore
    config = function(_, opts)
      local gitlab = require("gitlab")
      gitlab.setup(opts)
      vim.keymap.set("n", "glr", gitlab.review, { silent = false, desc = "gitlab review" })
      vim.keymap.set("n", "gls", gitlab.summary, { silent = false, desc = "gitlab summary" })
      vim.keymap.set("n", "glA", gitlab.approve, { silent = false, desc = "gitlab approve" })
      vim.keymap.set("n", "glR", gitlab.revoke, { silent = false, desc = "gitlab revoke" })
      vim.keymap.set("n", "glc", gitlab.create_comment, { silent = false, desc = "gitlab create comment" })
      vim.keymap.set("v", "glc", gitlab.create_multiline_comment, { silent = false, desc = "gitlab create multiline comment" })
      vim.keymap.set("v", "glC", gitlab.create_comment_suggestion, { silent = false, desc = "gitlab comment suggestion" })
      vim.keymap.set("n", "glm", gitlab.move_to_discussion_tree_from_diagnostic, { silent = false, desc = "gitlab discussion tree" })
      vim.keymap.set("n", "gln", gitlab.create_note, { silent = false, desc = "gitlab create note" })
      vim.keymap.set("n", "gld", gitlab.toggle_discussions, { silent = false, desc = "gitlab toggle discussions" })
      vim.keymap.set("n", "glaa", gitlab.add_assignee, { silent = false, desc = "gitlab add assignee" })
      vim.keymap.set("n", "glad", gitlab.delete_assignee, { silent = false, desc = "gitlab detele assignee" })
      vim.keymap.set("n", "glra", gitlab.add_reviewer, { silent = false, desc = "gitlab add reviewer" })
      vim.keymap.set("n", "glrd", gitlab.delete_reviewer, { silent = false, desc = "gitlab delete reviewer" })
      vim.keymap.set("n", "glp", gitlab.pipeline, { silent = false, desc = "gitlab pipeline" })
      vim.keymap.set("n", "glo", gitlab.open_in_browser, { silent = false, desc = "gitlab open in browser" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre" },
    -- dependencies = { "nvim-scrollbar" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    enabled = false,
    config = function()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar").setup()
    end,
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("git-worktree").setup(opts)
      require("telescope").load_extension("git_worktree")
    end,
  },
}
