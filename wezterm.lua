-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = wezterm.config_builder()

-- Colors / fonts
config.color_scheme = "zenbones_light"
config.font = wezterm.font("EnvyCodeR Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 14.0

-- macOS titlebar + tab look (Tahoe-ish)
config.window_decorations = "TITLE|RESIZE"
config.tab_max_width = 24
config.show_new_tab_button_in_tab_bar = true

-- One window_frame block (avoid duplicates)
config.window_frame = {
	-- System default UI font on macOS is San Francisco
	font = wezterm.font({ family = "SF Pro Display", weight = "Bold" }),
	-- alternatively try "SF Pro Text" or just "SF Pro"
	font_size = 13.0,
	active_titlebar_bg = "#E4E4E5",
	inactive_titlebar_bg = "#E4E4E5",
}

-- Tab bar colors
config.colors = config.colors or {}
config.colors.tab_bar = {
	background = "#E4E4E5",
	inactive_tab_edge = "rgba(0,0,0,0.08)",
	active_tab = { bg_color = "#F2F2F3", fg_color = "#303030" },
	inactive_tab = { bg_color = "#CACACB", fg_color = "#5F5F5F" },
	inactive_tab_hover = { bg_color = "#D9D9DA", fg_color = "#4A4A4A" },
	new_tab = { bg_color = "#CACACB", fg_color = "#5F5F5F" },
	new_tab_hover = { bg_color = "#D9D9DA", fg_color = "#303030" },
}

-- Gentle content padding to sit nicely under the title/tab bar
config.window_padding = { left = 8, right = 8, top = 12, bottom = 8 }

-- macOS niceties
config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 120
-- Optional translucency (comment these out if you prefer opaque)
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 20

-- Keyboard input behavior on macOS
config.use_dead_keys = false
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.scrollback_lines = 5000
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true

-- Startup: ensure we connect to the unix mux and maximize
config.unix_domains = { { name = "unix" } }
config.default_gui_startup_args = { "connect", "unix" }
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({ domain = { DomainName = "unix" } })
	window:gui_window():maximize()
end)

-- Keys: keep tab cycling on Cmd+Shift+Arrows, move pane nav to Ctrl+Cmd+Arrows
config.keys = {
	-- Tabs
	{ key = "LeftArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(1) },

	-- Panes (mac-friendly: keep plain Cmd+Arrows for text nav inside apps)
	{ key = "LeftArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Down") },

	-- Workspaces
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) },
}

-- Your SSH domains stay the same
config.ssh_domains = {
	{ name = "raspi", remote_address = "192.168.68.111", username = "aldi" },
	{ name = "storm", remote_address = "192.168.68.106", username = "aldi" },
}

-- Pill-like tab padding
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
	local pad_l, pad_r = "  ", "  "
	return {
		{ Background = { Color = tab.is_active and "#F2F2F3" or (hover and "#D9D9DA" or "#CACACB") } },
		{ Foreground = { Color = tab.is_active and "#303030" or (hover and "#4A4A4A" or "#5F5F5F") } },
		{ Text = pad_l .. title .. pad_r },
	}
end)

return config
