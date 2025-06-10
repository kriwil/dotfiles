-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- config.color_scheme = "Catppuccin Latte"
config.color_scheme = "zenbones_dark"
-- config.color_scheme = "zenwritten_light"

config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 14.

config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 13.0,

	-- active_titlebar_bg = "rgba(202 202 203 1)",
	-- inactive_titlebar_bg = "rgba(202 202 203 1)",
}

-- config.colors = {
-- 	tab_bar = {
-- 		inactive_tab_edge = "rgba(202 202 203 1)",
--
-- 		active_tab = {
-- 			bg_color = "rgba(228 228 229 1)",
-- 			fg_color = "#404040",
-- 		},
--
-- 		inactive_tab = {
-- 			bg_color = "rgba(202 202 203 1)",
-- 			fg_color = "#808080",
-- 		},
--
-- 		inactive_tab_hover = {
-- 			bg_color = "rgba(228 228 229 1)",
-- 			fg_color = "#808080",
-- 		},
--
-- 		new_tab = {
-- 			bg_color = "rgba(202 202 203 1)",
-- 			fg_color = "#808080",
-- 		},
--
-- 		new_tab_hover = {
-- 			bg_color = "rgba(228 228 229 1)",
-- 			fg_color = "#808080",
-- 		},
-- 	},
-- }

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.use_dead_keys = false
config.scrollback_lines = 5000

-- config.disable_default_key_bindings = true
config.keys = {
	{ key = "LeftArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(1) },

	{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },

	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) },
}

config.ssh_domains = {
	{
		name = "raspi",
		remote_address = "192.168.68.111",
		username = "aldi",
	},

	{
		name = "storm",
		remote_address = "192.168.68.106",
		username = "aldi",
	},
}

return config
