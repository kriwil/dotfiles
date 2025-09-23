-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = wezterm.config_builder()

-- ===== Colors / fonts =======================================================
config.color_scheme = "zenbones_light"

-- Prefer your font, but fall back gracefully (incl. emoji)
config.font = wezterm.font_with_fallback({
	{ family = "EnvyCodeR Nerd Font", weight = "Regular" },
	{ family = "SF Mono" },
	{ family = "JetBrains Mono" },
	{ family = "Apple Color Emoji" },
})
config.font_size = 14.0
-- Nicer shaping/ligatures without overdoing it
config.harfbuzz_features = { "calt", "liga", "clig" }

-- ===== macOS titlebar + tab look (Tahoe-ish) ===============================
config.window_decorations = "TITLE|RESIZE"
config.use_fancy_tab_bar = true
config.tab_max_width = 24
config.show_new_tab_button_in_tab_bar = true

-- One window_frame block (macOS system UI font)
config.window_frame = {
	-- San Francisco Display feels closest to macOS window title weight
	-- font = wezterm.font({ family = "SF Pro Display", weight = "Bold" }),
	-- If you prefer tighter spacing for small titles, try "SF Pro Text"
	font = wezterm.font({ family = "SF Pro Text", weight = "Bold" }),
	font_size = 13.0,
	active_titlebar_bg = "#E4E4E5",
	inactive_titlebar_bg = "#E4E4E5",
}

-- Tab bar (keep it light)
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

-- ===== macOS niceties / perf ===============================================
config.native_macos_fullscreen_mode = true
config.front_end = "WebGpu"
config.max_fps = 120
config.animation_fps = 120

-- Optional translucency
-- config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 20

-- Subtle focus guidance
config.inactive_pane_hsb = { brightness = 0.90, saturation = 0.95 }

-- ===== Keyboard / input =====================================================
config.use_dead_keys = false
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

config.scrollback_lines = 5000
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false
-- Always show tab bar
config.hide_tab_bar_if_only_one_tab = false

-- ===== Startup: connect to mux and maximize ================================
config.unix_domains = { { name = "unix" } }
config.default_gui_startup_args = { "connect", "unix" }
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({ domain = { DomainName = "unix" } })
	window:gui_window():maximize()
end)

-- ===== Smarter hyperlinks ===================================================
-- Make file paths, GitHub refs, and plain URLs clickable
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	-- file:///Users/aldi/...
	regex = [[\bfile://\S+\b]],
	format = "$0",
})
table.insert(config.hyperlink_rules, {
	-- owner/repo#123
	regex = [[\b([\w\-.]+)/([\w\-.]+)#(\d+)\b]],
	format = "https://github.com/$1/$2/issues/$3",
})
table.insert(config.hyperlink_rules, {
	-- GH PR shorthand
	regex = [[\bPR#(\d+)\b]],
	format = "https://github.com/search?q=$0",
})

-- ===== Right status (workspace · host · battery · time) ====================
wezterm.on("update-right-status", function(window, pane)
	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		local pct = math.floor(b.state_of_charge * 100)
		local ico = (b.state == "Charging") and "" or ""
		bat = string.format(" %s %d%%", ico, pct)
		break
	end

	local ws = window:active_workspace()
	local host = wezterm.hostname()
	local time = wezterm.strftime("%a %d %b %H:%M")

	window:set_right_status(wezterm.format({
		{ Background = { Color = "#E4E4E5" } }, -- light bg
		{ Foreground = { Color = "#303030" } }, -- dark readable text
		{ Text = "  " .. ws .. " · " .. host .. bat .. " · " .. time .. "  " },
	}))
end)

-- ===== Keys: tabs, panes, workspaces, splits, resize =======================
config.keys = {
	-- Tabs
	{ key = "LeftArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(1) },

	-- Panes (mac-friendly: keep plain Cmd+Arrows for in-app nav)
	{ key = "LeftArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Down") },

	-- Workspaces
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) },

	-- Splits (quick muscle memory)
	{ key = "d", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "D", mods = "SUPER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Resize panes
	{ key = "LeftArrow", mods = "ALT|CTRL|SUPER", action = act.AdjustPaneSize({ "Left", 2 }) },
	{ key = "RightArrow", mods = "ALT|CTRL|SUPER", action = act.AdjustPaneSize({ "Right", 2 }) },
	{ key = "UpArrow", mods = "ALT|CTRL|SUPER", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "ALT|CTRL|SUPER", action = act.AdjustPaneSize({ "Down", 1 }) },

	-- Misc
	{ key = "p", mods = "SUPER|SHIFT", action = act.ActivateCommandPalette },
	{ key = "r", mods = "SUPER|SHIFT", action = act.ReloadConfiguration },
}

-- ===== Mouse: Cmd-click to open links ======================================
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = act.OpenLinkAtMouseCursor,
	},
}

-- ===== SSH domains ==========================================================
config.ssh_domains = {
	{ name = "raspi", remote_address = "192.168.68.111", username = "aldi" },
	{ name = "storm", remote_address = "192.168.68.106", username = "aldi" },
}

-- ===== Pill-like tab padding ===============================================
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = wezterm.truncate_right(tab.active_pane.title, max_width - 2)
	local pad_l, pad_r = "  ", "  "
	local bg = tab.is_active and "#F2F2F3" or (hover and "#D9D9DA" or "#CACACB")
	local fg = tab.is_active and "#303030" or (hover and "#4A4A4A" or "#5F5F5F")
	return {
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = pad_l .. title .. pad_r },
	}
end)

return config
