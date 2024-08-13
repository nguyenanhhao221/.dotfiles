return {
  {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
				-- stylua: ignore
				keys = {
					{ "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
					{ "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
				},
        opts = {
          layouts = {
            {
              elements = {
                {
                  id = "breakpoints",
                  size = 0.25,
                },
                {
                  id = "stacks",
                  size = 0.25,
                },
                {
                  id = "watches",
                  size = 0.25,
                },
                {
                  id = "scopes",
                  size = 0.25,
                },
              },
              position = "left",
              size = 40,
            },
            {
              elements = {
                {
                  id = "repl",
                  size = 0.5,
                },
                {
                  id = "console",
                  size = 0.5,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        },
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_setup = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            "delve",
            "debuggy",
          },
        },
      },
    },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug Toggle Breakpoint" },
    { "<leader>dA", function() require("dap").clear_breakpoints() end, desc = "Debug Clear All Breakpoints" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Debug Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debug Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Debug Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Debug Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Debug Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Debug Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Debug Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Debug Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Debug Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Debug Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Debug Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Debug Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Debug Widgets" },
  },

    config = function()
      local Config = require("config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
}
