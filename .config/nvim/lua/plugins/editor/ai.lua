return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    enabled = false,
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    enabled = false,
    -- dependencies = {
    --   { "mason-org/mason.nvim", ensure_installed = { "copilot-language-server" } },
    -- },
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable("copilot_ls")
      vim.keymap.set("n", "<C-y>", function()
        -- Try to jump to the start of the suggestion edit.
        -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
        local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
          or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
      end)
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    event = "InsertEnter",
    cmd = {
      "SupermavenUseFree",
      "SupermavenUsePro",
    },
    opts = {
      keymaps = {
        accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
        -- clear_suggestion = "<C-]>",
        -- accept_word = "<C-j>",
      },
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      log_level = "info", -- set to "off" to disable logging completely
      disable_inline_completion = true,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
      disable_keymaps = true, -- disables built in keymaps for more manual control
      -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
      condition = function()
        return false
      end,
    },
  },
  -- Show Status if Supermaven-nvim plugin is enable
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        -- Colored mode icon
        function()
          local default_ai_plugins = {}
          local has_supermaven_api, supermaven_api = pcall(require, "supermaven-nvim.api")
          if has_supermaven_api and supermaven_api.is_running() then
            table.insert(default_ai_plugins, "Supermaven")
          end
          local has_copilot, _ = pcall(require, "copilot-lsp")
          if has_copilot then
            table.insert(default_ai_plugins, "Copilot")
          end

          if #default_ai_plugins > 0 then
            return table.concat(default_ai_plugins, ", ")
          end
          return ""
        end,
        icon = { " ", color = (vim.g.colors_name == "gruvbox") and "GruvboxGreen" or nil },
      })
    end,
  },
}
