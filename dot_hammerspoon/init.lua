PaperWM = hs.loadSpoon("PaperWM")
PaperWM.window_ratios = { 1 / 3, 1 / 2, 2 / 3 }
PaperWM:bindHotkeys({
	-- switch to a new focused window in tiled grid
	focus_left = { { "cmd" }, "left" },
	focus_right = { { "cmd" }, "right" },
	focus_up = { { "cmd" }, "up" },
	focus_down = { { "cmd" }, "down" },

	-- switch windows by cycling forward/backward
	-- (forward = down or right, backward = up or left)
	-- focus_prev = { { "alt", "cmd" }, "k" },
	-- focus_next = { { "alt", "cmd" }, "j" },

	-- move windows around in tiled grid
	swap_left = { { "cmd", "ctrl" }, "left" },
	swap_right = { { "cmd", "ctrl" }, "right" },
	swap_up = { { "cmd", "ctrl" }, "up" },
	swap_down = { { "cmd", "ctrl" }, "down" },

	-- position and resize focused window
	center_window = { { "cmd" }, "c" },
	full_width = { { "cmd" }, "f" },
	cycle_width = { { "cmd" }, "r" },
	reverse_cycle_width = { { "shift", "cmd" }, "r" },
	-- cycle_height = { { "alt", "cmd", "shift" }, "r" },
	-- reverse_cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "r" },

	-- increase/decrease width
	-- increase_width = { { "alt", "cmd" }, "l" },
	-- decrease_width = { { "alt", "cmd" }, "h" },

	-- move focused window into / out of a column
	-- slurp_in = { { "alt", "cmd" }, "i" },
	-- barf_out = { { "alt", "cmd" }, "o" },

	-- move the focused window into / out of the tiling layer
	toggle_floating = { { "alt", "cmd", "ctrl" }, "v" },
	-- raise all floating windows on top of tiled windows
	-- focus_floating = { { "alt", "cmd", "shift" }, "f" },

	-- focus the first / second / etc window in the current space
	focus_window_1 = { { "cmd" }, "1" },
	focus_window_2 = { { "cmd" }, "2" },
	focus_window_3 = { { "cmd" }, "3" },
	focus_window_4 = { { "cmd" }, "4" },
	focus_window_5 = { { "cmd" }, "5" },
	focus_window_6 = { { "cmd" }, "6" },
	focus_window_7 = { { "cmd" }, "7" },
	focus_window_8 = { { "cmd" }, "8" },
	focus_window_9 = { { "cmd" }, "9" },

	-- switch to a new Mission Control space
	switch_space_l = { { "alt", "cmd" }, "," },
	switch_space_r = { { "alt", "cmd" }, "." },
	switch_space_1 = { { "alt", "cmd" }, "1" },
	switch_space_2 = { { "alt", "cmd" }, "2" },
	switch_space_3 = { { "alt", "cmd" }, "3" },
	switch_space_4 = { { "alt", "cmd" }, "4" },
	switch_space_5 = { { "alt", "cmd" }, "5" },
	switch_space_6 = { { "alt", "cmd" }, "6" },
	switch_space_7 = { { "alt", "cmd" }, "7" },
	switch_space_8 = { { "alt", "cmd" }, "8" },
	switch_space_9 = { { "alt", "cmd" }, "9" },

	-- move focused window to a new space and tile
	move_window_1 = { { "cmd", "ctrl" }, "1" },
	move_window_2 = { { "cmd", "ctrl" }, "2" },
	move_window_3 = { { "cmd", "ctrl" }, "3" },
	move_window_4 = { { "cmd", "ctrl" }, "4" },
	move_window_5 = { { "cmd", "ctrl" }, "5" },
	move_window_6 = { { "cmd", "ctrl" }, "6" },
	move_window_7 = { { "cmd", "ctrl" }, "7" },
	move_window_8 = { { "cmd", "ctrl" }, "8" },
	move_window_9 = { { "cmd", "ctrl" }, "9" },
})
PaperWM:start()
