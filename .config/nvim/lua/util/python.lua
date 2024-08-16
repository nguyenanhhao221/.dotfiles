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

return M
