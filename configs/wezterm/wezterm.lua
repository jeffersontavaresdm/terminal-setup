local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- === APPEARANCE ===
-- Colors: Gruvbox Dark (Aci profile — bg/fg/cursor/ANSI palette)
config.colors = {
	foreground = "#ebdbb2",
	background = "#282828",
	cursor_bg = "#c4e9ff",
	cursor_fg = "#282828",
	cursor_border = "#c4e9ff",
	selection_fg = "#282828",
	selection_bg = "#d5c4a1",
	ansi = {
		"#000000", -- black
		"#cc0000", -- red
		"#4e9a06", -- green
		"#c4a000", -- yellow
		"#3465a4", -- blue
		"#75507b", -- magenta
		"#06989a", -- cyan
		"#d3d7cf", -- white
	},
	brights = {
		"#555753", -- bright black
		"#ef2929", -- bright red
		"#8ae234", -- bright green
		"#fce94f", -- bright yellow
		"#729fcf", -- bright blue
		"#ad7fa8", -- bright magenta
		"#34e2e2", -- bright cyan
		"#eeeeec", -- bright white
	},
	tab_bar = {
		background = "#1d2021",
		active_tab = { bg_color = "#282828", fg_color = "#ebdbb2" },
		inactive_tab = { bg_color = "#1d2021", fg_color = "#928374" },
		inactive_tab_hover = { bg_color = "#3c3836", fg_color = "#ebdbb2" },
	},
}
config.font = wezterm.font_with_fallback({
	{ family = "MesloLGS NF", weight = "Bold" },
	{ family = "JetBrainsMono Nerd Font", weight = "Medium" },
	{ family = "FiraCode Nerd Font", weight = "Medium" },
	"Noto Color Emoji",
})
config.font_size = 12.0
config.line_height = 1.15
config.cell_width = 1.0

-- Window
config.window_background_opacity = 1.0
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

-- Cursor (underline, matching Aci profile)
config.default_cursor_style = "BlinkingUnderline"
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
	{ key = "o", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

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
