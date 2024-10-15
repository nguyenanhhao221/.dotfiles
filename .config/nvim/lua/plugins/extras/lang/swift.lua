return {
  -- {
  --   "nvim-treesitter/nvim-treesitter",

  --   opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.sourcekit.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      })
    end,
  },
}
