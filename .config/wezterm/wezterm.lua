--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")
local helpers = require("utils.helpers")

local config = {
	-- Color Schemes
	color_scheme = "Catppuccin Mocha",
	-- Window
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 5,
		right = 5,
		top = 7,
		bottom = 5,
	},
	-- Background
	background = {
		{
			source = { File = { path = "/Users/haonguyen/Pictures/Wallpaper/thCDG1i.jpeg" } },
			height = "Cover",
			width = "Cover",
			horizontal_align = "Left",
			repeat_x = "Repeat",
			repeat_y = "Repeat",
			opacity = 1,
			-- speed = 200,
		},
		-- Add a black layer on top of the background so it easier to see the code
		{
			source = {
				Gradient = {
					colors = { helpers.is_dark() and "#000000" or "#ffffff" },
				},
			},
			width = "100%",
			height = "100%",
			opacity = helpers.is_dark() and 0.95 or 0.7,
		},
	},

	-- Tab Bar
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	-- Font
	font = wezterm.font("JetBrainsMono NFM"),
	font_size = 13,
	line_height = 1.1,
}
return config
