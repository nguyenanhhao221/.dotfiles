return {
  -- For Go test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-go")({}))
    end,
  },
}
