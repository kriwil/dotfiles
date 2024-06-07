-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "PaperColor Light (base16)"
config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 12.
config.use_fancy_tab_bar = true

config.window_frame = {
	-- font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font = wezterm.font("Helvetica Neue", { weight = "Bold", stretch = "Condensed", style = "Normal" }),

	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "rgba(202 202 203 1)",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "rgba(202 202 203 1)",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "rgba(202 202 203 1)",

		-- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#404040",
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "rgba(202 202 203 1)",
			fg_color = "#808080",
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#808080",
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "rgba(202 202 203 1)",
			fg_color = "#808080",
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#808080",
		},
	},
}

-- and finally, return the configuration to wezterm
return config
