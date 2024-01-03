-- Theme settings, use priority and lazy to config the main theme, other theme can be load with cmd later
-- Tokyonight themes
return {
  {
    "folke/tokyonight.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    name = "tokyonight",
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  --Kanagawa Themes
  {
    "rebelot/kanagawa.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    name = "kanagawa",
    opts = {
      compile = true, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      theme = "wave", -- Load "wave" theme when 'background' option is not set
      background = {
        -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    },
    config = function(_, opts)
      -- load the colorscheme here
      require("kanagawa").setup(opts)
      vim.cmd([[colorscheme kanagawa]])
    end,
  },
  --Rose pine
  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      disable_background = false,
      disable_float_background = false,
      disable_italics = false,

      --- @usage string hex value or named color from rosepinetheme.com/palette
      groups = {
        background = "base",
        background_nc = "_experimental_nc",
        panel = "surface",
        panel_nc = "base",
        border = "highlight_med",
        comment = "muted",
        link = "iris",
        punctuation = "subtle",

        error = "love",
        hint = "iris",
        info = "foam",
        warn = "gold",

        headings = {
          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
        -- or set all headings at once
        -- headings = 'subtle'
      },

      -- Change specific vim highlight groups
      -- https://github.com/rose-pine/neovim/wiki/Recipes
      highlight_groups = {
        ColorColumn = { bg = "rose" },

        -- Blend colours against the "base" background
        CursorLine = { bg = "foam", blend = 10 },
        StatusLine = { fg = "love", bg = "love", blend = 10 },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  --Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    name = "gruvbox",
    opts = {
      contrast = "soft", -- can be "hard", "soft" or empty string
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  --Gruvbox material
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    name = "gruvbox-material",
    config = function(_, opts)
      require("gruvbox-material").setup(opts)
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      transparent_background = true,
    },

    config = function(_, opts)
      -- load the colorscheme here
      require("catppuccin").setup(opts)
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  -- Or with configuration
  {
    "projekt0n/github-nvim-theme",
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark")
    end,
  },
}
