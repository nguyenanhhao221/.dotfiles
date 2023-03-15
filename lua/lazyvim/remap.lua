--Yank to the system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
--Move up and down and auto center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--Keep cursor in the middle when search term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--<C-c> behave like <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>")

--Move like in VSCode keymap
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x')

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>") -- increment
vim.keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- Save file
vim.keymap.set({ "n", "i", "v" }, "<C-s>", ":w<CR>", { desc = "[s]ave all files", noremap = true })

-- Format Command Trigger
vim.keymap.set({ "n", "i", "v" }, "<C-f>", ":Format<CR>", { desc = "[f]ormat with lsp", noremap = true })
--
-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[s]plit window [v]ertically" }) --
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[s]plit window [h]orizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "make [s]plit windows [e]qual" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "close current split window" }) -- close current split window

vim.keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

--Show git graph
vim.keymap.set("n", "<leader>gp", ":Flog<CR>", { desc = "Show [g]it gra[p]h" }) -- close current split window

--Disable the Q button
vim.keymap.set("n", "Q", "<nop>")

--Paste over and still keep the current pasted item in the buffer instead of the item that got pasted over
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Trouble Keymap
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
