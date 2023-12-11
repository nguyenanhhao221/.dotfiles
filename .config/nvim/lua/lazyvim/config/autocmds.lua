-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { ".swcrc" },
  callback = function()
    vim.api.nvim_set_option_value("filetype", "jsonc", { buf = 0 })
  end,
})
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "T0_prestart.yaml" },
  callback = function()
    vim.api.nvim_set_option_value("filetype", "yaml.ansible", { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { ".env", ".envrc" },
  callback = function()
    vim.filetype.add({
      filename = {
        [".env"] = "sh",
        ["*.env"] = "sh",
        [".envrc"] = "sh",
        ["*.envrc"] = "sh",
      },
    })
  end,
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
