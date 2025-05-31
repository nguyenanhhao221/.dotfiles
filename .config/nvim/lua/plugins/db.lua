return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = { { "gdb", "<cmd>DBUIToggle<cr>", desc = "toogle Vim Dad Bob UI for SQL" } },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbout",
      callback = function()
        vim.opt_local.foldenable = false
      end,
    })
  end,
}
