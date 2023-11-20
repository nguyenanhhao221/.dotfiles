local M = {}

-- Set up keymaps for LSP
M.on_attach = function(client, bufnr)
  -- Remap for lsp related
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  -- Hover docs
  nmap("<leader>k", ":Lspsaga hover_doc<CR>", "Hover Docs")
  -- nmap("<leader>k", vim.lsp.buf.hover, "Hover Docs")
  -- Code action
  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
  -- Go to definition
  nmap("<leader>gd", ":Lspsaga peek_definition<CR>", "Peek [G]o [D]efinition")
  -- nmap("gd", "<cmd>Telescope lsp_definitions<cr>", "[G]o [D]efinition")
  -- Type definition
  nmap("<leader>gt", ":Lspsaga peek_type_definition<CR>", "Peek [T]ype [D]efinition")

  --lsp finder toogle
  nmap("<leader>lf", ":Lspsaga lsp_finder<CR>", "[l]sp [f]inder")
  -- show  diagnostics for line
  nmap("<leader>D", ":Lspsaga show_line_diagnostics<CR>", "Show Line diagnostics")
  -- show diagnostics for cursor
  nmap("<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics")
  -- jump to previous diagnostic in buffer
  nmap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "jump to previous diagnostic in buffer")
  -- jump to next diagnostic in buffer
  nmap("]d", ":Lspsaga diagnostic_jump_next<CR>", "jump to next diagnostic in buffer")
  nmap("<leader>rn", ":Lspsaga rename<CR>", "[R]e[n]ame")
  nmap("<leader>sh", vim.lsp.buf.signature_help, "Signature Documentation")

  nmap("<leader>uf", require("lazyvim.plugins.lsp.format").toggle, "Toggle format on Save")
  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  if vim.lsp.inlay_hint then
    nmap("<leader>uh", function()
      vim.lsp.inlay_hint(0, nil)
    end, "Toggle Inlay Hints")
  end
end

return M
