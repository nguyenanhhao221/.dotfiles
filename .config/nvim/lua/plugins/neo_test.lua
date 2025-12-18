return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
    },
	-- stylua: ignore
    keys = function()
			nt = require("neotest")
      return {
        { "<leader>tt", function() nt.run.run(vim.fn.expand("%")) end, desc = "Run File", },
        { "<leader>tT", function() nt.run.run(vim.uv.cwd()) end, desc = "Run All Test Files",},
        { "<leader>tr", function() nt.run.run() end, desc = "Run Nearest", }, { "<leader>ts", function() nt.summary.toggle() end, desc = "Toggle Summary",},
        { "<leader>tl", function() nt.run.run_last() end, desc = "Run Last Test", },
				{ "<leader>to", function() nt.output.open({ enter = true, auto_close = true }) end, desc = "Show Output", },
        { "<leader>tO", function() nt.output_panel.toggle() end, desc = "Toggle Output Panel", },
				{ "<leader>tS", function() nt.run.stop() end, desc = "Stop", },
				{ "<leader>ta", function() nt.run.attach() end, desc = "Attach to a running process for the given position", },
      }
    end,
    opts = {
      discovery = {
        concurrent = 4, -- Adjust to performance issue with test discovery with pytest pytest
        enabled = true,
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
      icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "",
        unknown = "",
        watching = "",
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      local neotest = require("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      opts = vim.deepcopy(opts)

      local adapters = {}
      for k, v in pairs(opts.adapters) do
        if type(v) == "function" then
          table.insert(adapters, require(k)(v()))
        elseif v then
          table.insert(adapters, require(k)(v))
        else
          table.insert(adapters, require(k))
        end
      end
      opts.adapters = adapters
      if opts.consumers then
        for k, v in pairs(opts.consumers) do
          if type(v) == "function" then
            opts.consumers[k] = v()
          end
        end
      end

      neotest.setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>td", function() require("neotest").run.run({suite = false,strategy = "dap"}) end, desc = "Debug Nearest" },
			{ "<leader>tD", function() require("neotest").run.run({ suite = true, strategy = "dap" }) end, desc = "Debug Test Run All Suite" },
    },
  },
  --
  -- For test coverage
  {
    "andythigpen/nvim-coverage",
    enabled = true,
    cmd = { "Coverage", "CoverageSummary" },
    config = function()
      require("coverage").setup({
        commands = true, -- create commands
        highlights = {
          -- customize highlight groups created by the plugin
          covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
          uncovered = { fg = "#F07178" },
        },
        signs = {
          -- use your own highlight groups or text markers
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          -- customize the summary pop-up
          min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
        },
        lang = {
          -- customize language specific settings
        },
      })
    end,
  },
}
