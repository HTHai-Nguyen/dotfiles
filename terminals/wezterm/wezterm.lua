local wezterm = require("wezterm")
local config = wezterm.config_builder()

<<<<<<< HEAD
return {

	-- Appearance
	font_size = 13.0,
	window_background_opacity = 0.8,

	-- mouse keybindings
	--
	-- theme
	color_scheme = "Firewatch",

	-- Tabs bar
	hide_tab_bar_if_only_one_tab = true,

	-- Window
	window_decorations = "NONE",
	window_padding = { left = 5, right = 5, top = 5, bottom = 5 },
	initial_cols = 165,
	initial_rows = 50,
}
=======
--- Appearance ---
config.font_size = 13.0
config.color_scheme = "Firewatch"

--- Tab bar & Window ---
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

return config
>>>>>>> 8847c20e1a964150ff879daec0307d59d0e9af3c
