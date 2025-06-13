return {
  {
    "stevearc/oil.nvim",
    -- Optional dependencies
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    cmd = { "Oil" },
    keys = {
    -- stylua: ignore
      {"-", function() require("oil").open() end, desc = "Open Oil File explorer"},
      {
        "<leader>pv",
        function()
          require("oil").open()
        end,
        desc = "Open Oil File explorer",
      },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = false,
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
    },
  },
  -- surround
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  --Color preview
  {
    "NvChad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    opts = {
      tailwind = true, -- Enable tailwind colors
    },
  },
}
