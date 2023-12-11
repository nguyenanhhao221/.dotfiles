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
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
  -- See `:help lualine.txt`
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      local icons = require("lazyvim.config").icons

      return {
        options = {
          icons_enabled = true,
          component_separators = "|",
          section_separators = "",
          path = 1,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          globalstatus = true,
        },
        sections = {
          lualine_a = { { "mode", color = { fg = "#76787d" } } },
          lualine_b = {
            { "branch", color = { fg = "#76787d" }, icon = { "", align = "right", color = { fg = "#76787d" } } },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = fg("Constant"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              -- color = fg("Special"),
            },
            { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 1 } },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            -- function()
            --   return " " .. os.date("%R")
            -- end,
            "encoding",
          },
        },
      }
    end,
  },
  -- staline
  {
    "tamton-aquib/staline.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = function()
      local git_icons = require("lazyvim.config").icons.git
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
      return {
        sections = {
          left = {
            "cool_symbol",
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
                return git_status("added", git_icons.added) or ""
              end,
            },
            " ",
            {
              "GitSignsChange",
              function()
                return git_status("changed", git_icons.modified) or ""
              end,
            },
            " ",
            {
              "GitSignsDelete",
              function()
                return git_status("removed", git_icons.removed) or ""
              end,
            },
            "line_column",
          },
        },
        mode_colors = {
          -- i = "#76787d",
          n = "#76787d",
          c = "#76787d",
          v = "#76787d",
        },
        defaults = {
          true_colors = true,
          line_column = " [%l/%L] :%c  ",
          cool_symbol = " ",
          branch_symbol = " ",
        },
      }
    end,
  },
}
