--- Helper to inspect and print the content of a lua table
--- Ex: lua P(someTable)
---@param tableToPrint table: a Lua table
---@return table
P = function(tableToPrint)
  print(vim.inspect(tableToPrint))
  return tableToPrint
end
