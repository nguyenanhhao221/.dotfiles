return {
  "leoluz/nvim-dap-go",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dap = require("dap")
    dap.configurations.go = {
      {
        -- Must be "go" or it will be ignored by the plugin
        type = "go",
        name = "Attach remote",
        mode = "remote",
        request = "attach",
      },
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        name = "Launch Package",
        type = "go",
        request = "launch",
        mode = "auto",
        program = "${fileDirname}",
      },
    }
    require("dap-go").setup()
  end,
}
