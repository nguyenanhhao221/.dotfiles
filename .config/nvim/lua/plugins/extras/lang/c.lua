return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c" })
      end
    end,
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       c = { "cpplint" },
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {},
      },
    },
  },

  --DAP for C, C++, Cpp
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- config = function()
    --   local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
    --   local dap = require("dap")
    --   dap.adapters.cppdbg = {
    --     id = "cppdbg",
    --     type = "executable",
    --     command = mason_path .. "packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    --   }
    --   dap.configurations.c = {
    --     {
    --       name = "Launch file",
    --       type = "cppdbg",
    --       request = "launch",
    --       program = function()
    --         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --       end,
    --       cwd = "${workspaceFolder}",
    --       stopAtEntry = true,
    --     },
    --     {
    --       name = "Attach to gdbserver :1234",
    --       type = "cppdbg",
    --       request = "launch",
    --       MIMode = "gdb",
    --       miDebuggerServerAddress = "localhost:1234",
    --       miDebuggerPath = "/usr/bin/gdb",
    --       cwd = "${workspaceFolder}",
    --       program = function()
    --         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    --       end,
    --     },
    --   }
    --   require("dap.ext.vscode").load_launchjs(nil)
    -- end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
}
