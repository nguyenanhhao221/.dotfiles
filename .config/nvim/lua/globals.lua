--- Helper to inspect and print the content of a lua table
--- Ex: lua P(someTable)
---@param tableToPrint table: a Lua table
---@return table
P = function(tableToPrint)
  print(vim.inspect(tableToPrint))
  return tableToPrint
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

---
---@param name string: package name
R = function(name)
  RELOAD(name)
  return require(name)
end
