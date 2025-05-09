local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font("FiraCode Nerd Font")
config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.max_fps = 120
config.enable_kitty_graphics = true
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 0.67
config.macos_window_background_blur = 12
config.audible_bell = "Disabled"

config.window_padding = {
	left = 18,
	right = 15,
	top = 20,
	bottom = 5,
}

-- Key bindings delete word
config.keys = {
	{
		key = "}",
		mods = "OPT",
		action = wezterm.action({ SendString = "`" }),
	},
	{
		key = "q",
		mods = "OPT",
		action = wezterm.action({ SendString = "@" }),
	},
}

-- Configs
-- Add Custom Color Scheme
config.color_scheme = "rose-pine"
config.colors = {
	-- background = "#12151B", -- lighter gray
	-- background = "#0D0D0D", -- darker gray
	background = "#000", -- pure black
	cursor_bg = "#9B96B5",
	cursor_fg = "#1a1a1e",
	cursor_border = "#9B96B5",
	tab_bar = {
		active_tab = {
			bg_color = "#12151B",
			fg_color = "#f8f8f2",
		},
		inactive_tab = {
			bg_color = "#282a36",
			fg_color = "#f8f8f2",
		},
		new_tab = {
			bg_color = "#44475a",
			fg_color = "#ffffff",
		},
	},
}

return config
