-- Theme settings, use priority and lazy to config the main theme, other theme can be load with cmd later
-- Tokyonight themes
return {
  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    name = "tokyonight",
    opts = {
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      on_highlights = function(highlights, colors)
        highlights.TelescopeSelection = {
          bg = colors.bg_highlight,
        }
      end,
    },
    config = function(_, opts)
      -- load the colorscheme here
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  --Kanagawa Themes
  {
    "rebelot/kanagawa.nvim",
    enabled = true,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    name = "kanagawa",
    opts = {
      compile = true, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      terminalColors = false, -- define vim.g.terminal_color_{0,17}
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        return {
          -- theme colors will update dynamically when you change theme!
          StatusLine = { bg = "none" },
        }
      end,
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
    enabled = true,
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
      disable_italics = true,

      --- @usage string hex value or named color from rosepinetheme.com/palette
      --   groups = {
      --     background = "base",
      --     background_nc = "_experimental_nc",
      --     panel = "surface",
      --     panel_nc = "base",
      --     border = "highlight_med",
      --     comment = "muted",
      --     link = "iris",
      --     punctuation = "subtle",
      --
      --     error = "love",
      --     hint = "iris",
      --     info = "foam",
      --     warn = "gold",
      --
      --     headings = {
      --       h1 = "iris",
      --       h2 = "foam",
      --       h3 = "rose",
      --       h4 = "gold",
      --       h5 = "pine",
      --       h6 = "foam",
      --     },
      --     -- or set all headings at once
      --     -- headings = 'subtle'
      --   },
      --
      --   -- Change specific vim highlight groups
      --   -- https://github.com/rose-pine/neovim/wiki/Recipes
      --   highlight_groups = {
      --     ColorColumn = { bg = "rose" },
      --
      --     -- Blend colours against the "base" background
      --     CursorLine = { bg = "foam", blend = 10 },
      --     StatusLine = { fg = "love", bg = "love", blend = 10 },
      --   },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  --Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    -- dir = "/Users/haonguyen/Code/gruvbox.nvim", -- Pass in the path to your cloned repository
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    name = "gruvbox",
    opts = {
      strikethrough = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = true,
      },
      contrast = "hard", -- can be "hard", "soft" or empty string
      transparent_mode = false,
      palette_overrides = {
        -- dark0_hard = "#09090B",
        --   dark0 = "#09090B",
      },
      overrides = {
        -- TelescopeSelection = {
        --   bg = "#665c54",
        -- },
        -- TelescopeMatching = {
        --   link = "GruvboxOrange",
        -- },
        SignColumn = {
          link = "GruvboxBg0",
        },
        CursorLineNr = {
          link = "GruvboxYellow",
        },
        StatusLine = {
          link = "GruvboxGray",
        },
        -- NormalFloat = {
        --   link = "GruvboxBg0",
        -- },
        FloatBorder = {
          link = "Comment",
        },
        -- DiffText = {
        --   link = "Question",
        -- },
        EndOfBuffer = {
          link = "GruvboxBg0",
        },
        DiagnosticSignOk = {
          link = "DiagnosticOk",
        },
        DiagnosticSignError = {
          link = "DiagnosticError",
        },
        DiagnosticSignWarn = {
          link = "DiagnosticWarn",
        },
        DiagnosticSignInfo = {
          link = "DiagnosticInfo",
        },
        DiagnosticSignHint = {
          link = "DiagnosticHint",
        },
        DiffDelete = {
          strikethrough = true,
        },
      },
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
    enabled = true,
    lazy = true,
    -- priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_float_style = "bright"
      vim.g.gruvbox_material_statusline_style = "material"
      vim.g.gruvbox_material_cursor = "auto"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    lazy = true,
    -- priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      transparent_background = false,
      term_colors = true,
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
    enabled = true,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          -- Compiled file's destination location
          styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
          },
        },
      })
      vim.cmd("colorscheme github_dark_default")
    end,
  },
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    enabled = true,
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000,
    config = function()
      vim.cmd("colorscheme carbonfox")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    enabled = true,
    lazy = true,
    -- priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = false,
        hide_fillchars = false,
        borderless_telescope = true,
        terminal_colors = true,
        cache = true,
      })
      vim.cmd("colorscheme cyberdream")
    end,
  },
}
