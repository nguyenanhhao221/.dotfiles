return {
  {
    -- Obsidian
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = function()
      local path = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsidianNote"
      return {
        workspaces = {
          {
            name = "personal",
            path = path,
          },
        },
        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
          nvim_cmp = false,
          -- Enables completion using blink.cmp
          blink = true,
          -- Trigger completion at 2 chars.
          min_chars = 2,
        },
      }
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      -- For obsidian.nvim
      { "saghen/blink.compat" },
      { "hrsh7th/nvim-cmp" },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      per_filetype = {
        markdown = { "obsidian", "obsidian_new", "obsidian_tags" },
      },
      providers = {
        obsidian = {
          name = "obsidian",
          module = "blink.compat.source",
        },
        obsidian_new = {
          name = "obsidian_new",
          module = "blink.compat.source",
        },
        obsidian_tags = {
          name = "obsidian_tags",
          module = "blink.compat.source",
        },
      },
    },
  },
}
