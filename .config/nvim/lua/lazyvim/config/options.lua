--Set <Space> as leader key
--Must happen before any plugin is loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true
-- Always have at least 8 line below when scroll
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
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""

vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
