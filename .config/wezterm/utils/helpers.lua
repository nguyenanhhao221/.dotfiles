local M = {}
local wezterm = require("wezterm")

local appearance = wezterm.gui.get_appearance()

M.is_dark = function()
	return appearance:find("Dark")
end

return M
