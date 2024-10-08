return {
  -- Debug Python
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class" },
      },
      ft = { "python" },
      config = function()
        local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
        local dap = require("dap")
        -- dap.configurations.python = {
        --   {
        --     name = "Python: Module",
        --     type = "python",
        --     module = "datamimic",
        --     request = "launch",
        --     justMyCode = true,
        --   },
        -- }
        require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
        require("dap.ext.vscode").load_launchjs(nil)
      end,
    },
  },
}
