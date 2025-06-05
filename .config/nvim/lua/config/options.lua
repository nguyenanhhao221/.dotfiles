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
vim.wo.signcolumn = "yes:2"

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

vim.opt.cursorline = true -- Highlighting of the current line
vim.opt.cursorlineopt = "number" -- Only highlight the column number on the left instead of the whole line
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- options to stop weird indent on newline
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Make cursor fat even in insert mode
vim.opt.guicursor = ""
vim.opt.guicursor = "i:blinkwait300-blinkon200-blinkoff150"

-- Set border for all floating window
-- vim.o.winborder = "rounded"
