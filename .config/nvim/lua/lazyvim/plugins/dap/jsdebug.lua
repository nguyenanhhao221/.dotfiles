return {
  --DAP, Related config and settings for debugging
  {
    "mxsdev/nvim-dap-vscode-js",
    event = "VeryLazy",
    dependencies = {
      {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = { "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" },
      },
      {
        "mfussenegger/nvim-dap",
      },
    },
    opts = {
      -- Path to vscode-js-debug installation.
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      -- which adapters to register in nvim-dap},
      adapters = {
        "chrome",
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
        "node",
      },
    },
    config = function(_, opts)
      local js_based_languages = { "typescript", "javascript", "typescriptreact" }
      for _, language in ipairs(js_based_languages) do
        require("dap").configurations[language] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome against localhost",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
          },
          {
            name = "Attach to Chrome",
            port = 9222,
            request = "attach",
            type = "pwa-chrome",
            webRoot = "${workspaceFolder}",
          },
          {
            name = "Next.js: debug client-side",
            type = "pwa-chrome",
            request = "launch",
            sourceMaps = true,
            url = "http://localhost:3000",
          },
          {
            name = "Next.js: debug full stack",
            type = "node-terminal",
            request = "launch",
            command = "pnpm run dev",
            serverReadyAction = {
              pattern = "started server on .+, url: (https?://.+)",
              uriFormat = "%s",
              action = "debugWithChrome",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node)",
            cwd = vim.fn.getcwd(),
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "--loader", "ts-node/esm" },
            runtimeExecutable = "node",
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with jest)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
            runtimeExecutable = "node",
            args = { "${file}", "--coverage", "false" },
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with vitest)",
            cwd = vim.fn.getcwd(),
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
            autoAttachChildProcesses = true,
            smartStep = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome, select port)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
              return vim.fn.input("Select port: ", 9222)
            end,
            webRoot = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach Program (pwa-node, select pid)",
            cwd = vim.fn.getcwd(),
            processId = require("dap.utils").pick_process,
            skipFiles = { "<node_internals>/**" },
          },
        }
      end
      require("dap-vscode-js").setup(opts)
    end,
  },
}
