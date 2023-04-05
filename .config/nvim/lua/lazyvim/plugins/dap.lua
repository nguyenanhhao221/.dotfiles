return {
  --DAP, Related config and settings for debugging
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = { "mxsdev/nvim-dap-vscode-js", "rcarriga/nvim-dap-ui" },
    config = function()
      local dap_status, dap = pcall(require, "dap")
      if not dap_status then
        return
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = "Debug: " .. desc
        end

        vim.keymap.set("n", keys, func, { desc = desc })
      end

      -- Set keymaps to control the debugger
      nmap("<F5>", dap.continue, "Debug continue")
      nmap("<F10>", dap.step_over, "Debug step over")
      nmap("<F11>", dap.step_into, "Debug step into")
      nmap("<F12>", dap.step_out, "Debug step out")
      nmap("<leader>b", dap.toggle_breakpoint, "Debug set Breakpoint")
      nmap("<leader>B", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, "Breakpoint condition")

      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
      local js_based_languages = { "typescript", "javascript", "typescriptreact" }
      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = 'Start Chrome with "localhost"',
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
          },
        }
      end
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- Javascript debug
      require("dap-vscode-js").setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters = {
          "chrome",
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
          "node",
          "chrome",
        }, -- which adapters to register in nvim-dap
        -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
        -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
        -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      })
    end,
  },
  {
    "microsoft/vscode-js-debug",
    lazy = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

      vim.keymap.set("n", "<leader>ui", require("dapui").toggle)
    end,
  },
}
