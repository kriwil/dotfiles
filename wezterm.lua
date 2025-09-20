-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.color_scheme = "zenbones_light"
-- config.color_scheme = "zenwritten_light"

config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 14.

config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 13.0,
}

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

config.unix_domains = {
	{
		name = "unix",
	},
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { "connect", "unix" }

-- Make WezTerm look like macOS Terminal (Tahoe/Sequoia style)
config.window_decorations = "TITLE|RESIZE" -- native titlebar
config.tab_max_width = 24
config.show_new_tab_button_in_tab_bar = true

-- Titlebar colors to match macOS light chrome
config.window_frame = {
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 13.0,
	active_titlebar_bg = "#E4E4E5", -- light neutral
	inactive_titlebar_bg = "#E4E4E5",
}

-- Tab bar colors: soft active tab, muted inactive, subtle edge
config.colors = config.colors or {}
config.colors.tab_bar = {
	background = "#E4E4E5", -- bar background (blends with titlebar)
	inactive_tab_edge = "rgba(0,0,0,0.08)",

	active_tab = {
		bg_color = "#F2F2F3", -- slightly lighter “pill”
		fg_color = "#303030",
		intensity = "Normal",
		italic = false,
		strikethrough = false,
		underline = "None",
	},

	inactive_tab = {
		bg_color = "#CACACB", -- muted gray
		fg_color = "#5F5F5F",
	},

	inactive_tab_hover = {
		bg_color = "#D9D9DA", -- hover lift
		fg_color = "#4A4A4A",
	},

	new_tab = {
		bg_color = "#CACACB",
		fg_color = "#5F5F5F",
	},

	new_tab_hover = {
		bg_color = "#D9D9DA",
		fg_color = "#303030",
	},
}

-- Add gentle left/right padding so the active tab feels “pill-like”
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
	local pad_l = "  "
	local pad_r = "  "
	return {
		{ Background = { Color = tab.is_active and "#F2F2F3" or (hover and "#D9D9DA" or "#CACACB") } },
		{ Foreground = { Color = tab.is_active and "#303030" or (hover and "#4A4A4A" or "#5F5F5F") } },
		{ Text = pad_l .. title .. pad_r },
	}
end)

return config
