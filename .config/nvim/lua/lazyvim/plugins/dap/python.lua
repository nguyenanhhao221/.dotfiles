return {
  -- Debug Python
  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      local dap = require("dap")
      dap.configurations.python = {
        {
          -- Must be "go" or it will be ignored by the plugin
          name = "Python: Module",
          type = "python",
          module = "benerator",
          request = "launch",
          justMyCode = true,
        },
      }
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
    end,
  },
}
