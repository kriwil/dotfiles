-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "PaperColor Light (base16)"

config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 12.

config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 12.0,

	active_titlebar_bg = "rgba(202 202 203 1)",
	inactive_titlebar_bg = "rgba(202 202 203 1)",
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "rgba(202 202 203 1)",

		active_tab = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#404040",
		},

		inactive_tab = {
			bg_color = "rgba(202 202 203 1)",
			fg_color = "#808080",
		},

		inactive_tab_hover = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#808080",
		},

		new_tab = {
			bg_color = "rgba(202 202 203 1)",
			fg_color = "#808080",
		},

		new_tab_hover = {
			bg_color = "rgba(228 228 229 1)",
			fg_color = "#808080",
		},
	},
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.use_dead_keys = false
config.scrollback_lines = 5000

config.disable_default_key_bindings = true
config.keys = {
	{ key = "m", mods = "SUPER", action = act.Hide },
	{ key = "h", mods = "SUPER", action = act.HideApplication },
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "Copy", action = act.CopyTo("Clipboard") },
	{ key = "Paste", action = act.PasteFrom("Clipboard") },

	{ key = "r", mods = "SUPER|SHIFT", action = act.ReloadConfiguration },

	{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "LeftArrow", mods = "SUPER", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
	{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
	{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
	{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
	{ key = "9", mods = "SUPER", action = act.ActivateTab(8) },
	{ key = "0", mods = "SUPER", action = act.ActivateTab(-1) },

	{ key = "v", mods = "SUPER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
}

return config
