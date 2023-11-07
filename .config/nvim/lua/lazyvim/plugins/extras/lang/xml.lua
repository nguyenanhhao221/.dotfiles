return {
  -- set up lsp for xml
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lemminx = {},
      },
    },
  },
}
