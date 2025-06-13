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
	-- https://wezterm.org/colorschemes/index.html
	color_scheme = "Gruvbox dark, hard (base16)",
	-- Window
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 0,
	},

	-- Tab Bar
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	-- Font
	font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" }),
	font_size = 13,
	line_height = 1,
	bold_brightens_ansi_colors = true,

	-- Cursor
	cursor_blink_rate = 0, --0 Disable blinking
	-- Disable all keymap from Wezterm
	disable_default_key_bindings = true,
}
-- maximize window on startup
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local _, _, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)
return config
