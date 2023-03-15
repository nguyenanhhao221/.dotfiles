require("lazyvim.remap")
require("lazyvim.lazy")

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true
-- Always have atleast 8 line below when scroll
vim.opt.scrolloff = 8
--Fast update time, the time vim will wait to execute after you press the key
vim.opt.updatetime = 100
--Set relative line number
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"

--Enable break indent
vim.o.breakindent = true

-- Set colorscheme
vim.o.termguicolors = true
-- No wrap words
vim.opt.wrap = false

-- Spell lang
vim.opt.spelllang = { "en" }
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

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

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et