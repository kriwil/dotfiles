-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.color_scheme = "zenbones"

config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 11.

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
		remote_address = "192.168.68.103",
		username = "pi",
	},

	{
		name = "storm",
		remote_address = "192.168.68.106",
		username = "aldi",
	},
}

return config
