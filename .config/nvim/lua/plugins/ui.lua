local icons = require("config.init").icons

return {
  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      -- https://patorjk.com/software/taag/#p=testall&f=Graffiti&t=Hao%20Nguyen
      local logo = [[
      ██╗  ██╗ █████╗  ██████╗     ███╗   ██╗ ██████╗ ██╗   ██╗██╗   ██╗███████╗███╗   ██╗
      ██║  ██║██╔══██╗██╔═══██╗    ████╗  ██║██╔════╝ ██║   ██║╚██╗ ██╔╝██╔════╝████╗  ██║
      ███████║███████║██║   ██║    ██╔██╗ ██║██║  ███╗██║   ██║ ╚████╔╝ █████╗  ██╔██╗ ██║
      ██╔══██║██╔══██║██║   ██║    ██║╚██╗██║██║   ██║██║   ██║  ╚██╔╝  ██╔══╝  ██║╚██╗██║
      ██║  ██║██║  ██║╚██████╔╝    ██║ ╚████║╚██████╔╝╚██████╔╝   ██║   ███████╗██║ ╚████║
      ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝     ╚═╝  ╚═══╝ ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝╚═╝  ╚═══╝
    ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
          tabline = true,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
          { action = "Telescope git_status",                                     desc = " Git Status",      icon = " ", key = "s" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    opts = {
      draw = {
        animation = function()
          return 0
        end,
      },
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "nvim-tree" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
  -- https://github.com/nvim-lualine/lualine.nvim
  -- Set lualine as statusline
  -- Using my own configuration "mini_lualine"
  -- See `:help lualine.txt`
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, opts)
      local lualine = require("lualine")
      local has_mini_lualine, mini_lualine_config = pcall(require, "haonguyen.mini_lualine")
      if not has_mini_lualine then
        return lualine.setup(opts)
      end
      lualine.setup(mini_lualine_config)
    end,
  },
  -- staline
  {
    "tamton-aquib/staline.nvim",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    enabled = false,
    opts = function()
      local git_status = function(type, prefix)
        local status = vim.b.gitsigns_status_dict
        if not status then
          return nil
        end
        if not status[type] or status[type] == 0 then
          return nil
        end
        return prefix .. status[type]
      end
      vim.cmd([[hi NeovimLogo guifg=#69A33E]])
      return {
        sections = {
          left = {
            { "NeovimLogo", "cool_symbol" },
            " ",
            "branch",
            " ",
            "file_name",
            " ",
          },
          mid = { "lsp" },
          right = {
            {
              "GitSignsAdd",
              function()
                return git_status("added", icons.git.added) or ""
              end,
            },
            " ",
            {
              "GitSignsChange",
              function()
                return git_status("changed", icons.git.modified) or ""
              end,
            },
            " ",
            {
              "GitSignsDelete",
              function()
                return git_status("removed", icons.git.removed) or ""
              end,
            },
            "line_column",
          },
        },
        mode_colors = {
          i = "#76787d",
          n = "#76787d",
          c = "#76787d",
          v = "#76787d",
        },
        defaults = {
          true_colors = true,
          line_column = " [%l/%l] :%c  ",
          cool_symbol = " ",
          branch_symbol = " ",
        },
      }
    end,
  },
}
