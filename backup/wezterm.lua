local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- === APPEARANCE ===
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	{ family = "FiraCode Nerd Font", weight = "Medium" },
	{ family = "MesloLGS NF" },
	"Noto Color Emoji",
})
config.font_size = 11.0
config.line_height = 1.15
config.cell_width = 1.0

-- Window
config.window_background_opacity = 0.92
config.window_padding = { left = 12, right = 12, top = 8, bottom = 8 }
config.window_decorations = "RESIZE"
config.enable_scroll_bar = false
config.initial_rows = 40
config.initial_cols = 140

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- === PERFORMANCE ===
config.front_end = "OpenGL"
config.max_fps = 120
config.animation_fps = 60
config.scrollback_lines = 10000

-- === SHELL ===
config.default_prog = { "zsh", "-l" }

-- === KEYBINDINGS ===
local act = wezterm.action
config.keys = {
	-- Splits (Alt + arrows style)
	{ key = "d", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Navigate panes
	{ key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },

	-- Resize panes
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 3 }) },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 3 }) },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 3 }) },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 3 }) },

	-- Close pane
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

	-- New tab
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

	-- Tab navigation
	{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = act.ActivateTab(4) },

	-- Font size
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },

	-- Quick copy mode
	{ key = "f", mods = "CTRL|SHIFT", action = act.Search("CurrentSelectionOrEmptyString") },
}

-- === TAB TITLE ===
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
	local title = tab.active_pane.title
	if title and #title > 0 then
		title = title:gsub("^(.-)%s*%-.*", "%1")
	end
	if #title > max_width - 4 then
		title = title:sub(1, max_width - 5) .. "…"
	end
	local index = tab.tab_index + 1
	return " " .. index .. ": " .. title .. " "
end)

return config
