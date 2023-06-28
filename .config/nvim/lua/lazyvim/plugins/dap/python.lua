return {
  {
    "mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = {
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet" },
            runner = "pytest",
          }),
        },
      })
    end,
  },
}
