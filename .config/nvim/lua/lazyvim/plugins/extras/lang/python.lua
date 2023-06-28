return {
  {
    "ChristianChiarulli/swenv.nvim",
    event = "VeryLazy",
    opts = {
      -- Should return a list of tables with a `name` and a `path` entry each.
      -- Gets the argument `venvs_path` set below.
      -- By default just lists the entries in `venvs_path`.
      get_venvs = function(venvs_path)
        return require("swenv.api").get_venvs(venvs_path)
      end,
      -- Path passed to `get_venvs`.
      venvs_path = vim.fn.expand("~/venvs"),
      -- Something to do after setting an environment, for example call vim.cmd.LspRestart
      post_set_venv = nil,
    },
    config = function(_, opts)
      require("swenv").setup(opts)
      vim.keymap.set("n", "<leader>ev", "<cmd>lua require('swenv.api').pick_venv()<cr>", { desc = "Choose env" }) --
    end,
  },
  -- For Python test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
          dap = {
            justMyCode = false,
            console = "integratedTerminal",
          },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        })
      )
    end,
  },
}
