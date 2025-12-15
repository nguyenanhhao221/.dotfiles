local M = {}

--- Helper to get the command in venv virtual environment
---@param command string
M.get_venv_command = function(command)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/" .. command
  else
    return command
  end
end

--- Get the name of the current virtual environment
---@return string|nil
M.get_venv_name = function()
  if vim.env.VIRTUAL_ENV then
    -- Extract the venv name from the path (last directory)
    return vim.fn.fnamemodify(vim.env.VIRTUAL_ENV, ":t")
  end
  return nil
end

return M
