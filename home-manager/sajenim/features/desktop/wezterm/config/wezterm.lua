-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	return { { Text = " " .. title .. "" } }
end)

-- Do not check for or show window with update information
config.check_for_updates = false

--| Font Configuration
config.font = wezterm.font("Fisa Code")
config.font_size = 10.0

--| Color scheme
config.color_scheme = "gruvbox_material_dark_hard"

--| Cursor style
config.default_cursor_style = "SteadyBar"

--| Padding
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

--| Style Inactive Panes
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

--| Tab Bar Appearance
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.tab_max_width = 24
config.show_tab_index_in_tab_bar = false

--| Colors
config.colors = {

	tab_bar = {
		--| Tab Bar Colors
		background = "#282828",
		--| Tab Colors
		active_tab = { bg_color = "#282828", fg_color = "#7daea3", intensity = "Normal", italic = false },
		inactive_tab = { bg_color = "#282828", fg_color = "#a89984", intensity = "Normal", italic = false },
		inactive_tab_hover = { bg_color = "#282828", fg_color = "#a89984", intensity = "Normal", italic = false },
		new_tab = { bg_color = "#282828", fg_color = "#a89984", intensity = "Normal", italic = false },
		new_tab_hover = { bg_color = "#282828", fg_color = "#a89984", intensity = "Normal", italic = false },
	},
}

--| Key Assignments
config.disable_default_key_bindings = true
config.keys = {
	--| Spawn Tab
	{ key = "Enter", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	--| Tab Navigation
	{ key = "LeftArrow", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "ALT", action = act.ActivateTabRelative(1) },

	--| Split Panes
	{ key = "v", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	--| Adjust Pane Size
	{ key = "PageDown", mods = "ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "PageUp", mods = "ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
	--| Pane Navigation
	{ key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Next") },
	{ key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Prev") },
	--| Close Pane
	{ key = "Escape", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },

	--| Copy Mode / Clipboard
	{ key = "X", mods = "CTRL", action = act.ActivateCopyMode },
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	--| This lets us unify delete word across programs
	{ key = "Backspace", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
}

return config
