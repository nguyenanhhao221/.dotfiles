local M = {}

-- Set up keymaps for LSP
M.on_attach = function(_, bufnr)
  -- Remap for lsp related
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  -- Hover docs
  -- nmap("<leader>k", ":Lspsaga hover_doc<CR>", "Hover Docs")
  nmap("<leader>k", vim.lsp.buf.hover, "Hover Docs")
  -- Code action
  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

  --lsp finder toogle
  -- nmap("<leader>lf", ":Lspsaga lsp_finder<CR>", "[l]sp [f]inder")
  -- show  diagnostics for line
  -- nmap("<leader>D", ":Lspsaga show_line_diagnostics<CR>", "Show Line diagnostics")
  nmap("<leader>D", function()
    vim.diagnostic.open_float({ scope = "line" })
  end, "Show Line diagnostics")
  -- show diagnostics for cursor
  nmap("<leader>d", function()
    vim.diagnostic.open_float({ scope = "cursor" })
  end, "Show cursor diagnostics")
	-- stylua: ignore
  -- nmap("<leader>d",vim.diagnostic.open_float({scope = "cursor"}),"Show cursor diagnostics")
  -- jump to previous diagnostic in buffer
  -- nmap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "jump to previous diagnostic in buffer")
  nmap("[d", vim.diagnostic.goto_prev, "jump to previous diagnostic in buffer")
  -- jump to next diagnostic in buffer
  -- nmap("]d", ":Lspsaga diagnostic_jump_next<CR>", "jump to next diagnostic in buffer")
  nmap("]d", vim.diagnostic.goto_next, "jump to next diagnostic in buffer")
  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>sh", vim.lsp.buf.signature_help, "Signature Documentation")

  nmap("<leader>uf", require("plugins.lsp.format").toggle, "Toggle format on Save")
  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  vim.keymap.set("i", "<c-i>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
end

return M
