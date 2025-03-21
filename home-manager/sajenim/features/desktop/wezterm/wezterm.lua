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

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
	  local title = tab_title(tab)
	  return {
      { Text = ' ' .. title .. '' }
    }
end)

-- Do not check for or show window with update information
config.check_for_updates = false

--| Font configuration
config.font = wezterm.font("Fisa Code")
config.font_size = 10.0

--| Enable gruvbox colour scheme
config.color_scheme = "gruvbox_material_dark_medium"

--| Pad window borders
config.window_padding = {
	left   = 10,
	right  = 10,
	top    = 10,
	bottom = 10,
}

--| Disable modern tab bar
config.use_fancy_tab_bar = false
config.tab_max_width = 32

--| Tab bar colors
config.colors = {
  tab_bar = {
		background = "#32302f",
		active_tab = {
      bg_color = "#32302f",
      fg_color = "#7daea3",
      intensity = "Bold",
      italic = true
    },
		inactive_tab = {
      bg_color = "#32302f",
      fg_color = "#a89984",
      intensity = "Bold",
      italic = true
    },
		inactive_tab_hover = {
      bg_color = "#32302f",
      fg_color = "#a89984",
      intensity = "Bold",
      italic = true
    },
		new_tab = {
      bg_color = "#32302f",
      fg_color = "#a89984",
      intensity = "Bold",
      italic = true
    },
		new_tab_hover = {
      bg_color = "#32302f",
      fg_color = "#a89984",
      intensity = "Bold",
      italic = true
    }
  }
}

--| Key assignments
config.keys = {
	{ -- Spawn new tab
    key = "Enter",
    mods = "ALT",
    action = act.SpawnTab("CurrentPaneDomain")
  },

	{ -- Focus previous tab
    key = "LeftArrow",
    mods = "ALT",
    action = act.ActivateTabRelative(-1)
  },

	{ -- Focus next tab
    key = "RightArrow",
    mods = "ALT",
    action = act.ActivateTabRelative(1)
  },

	{ -- Split pane vertically
    key = "v",
    mods = "ALT",
    action = act.SplitVertical({domain = "CurrentPaneDomain"})
  },

	{ -- Split pane horizontally
    key = "s",
    mods = "ALT",
    action = act.SplitHorizontal({domain = "CurrentPaneDomain"})
  },

	{ -- Move pane split down
    key = "PageDown",
    mods = "ALT",
    action = act.AdjustPaneSize({"Down", 5})
  },

	{ -- Move pane split up
    key = "PageUp",
    mods = "ALT",
    action = act.AdjustPaneSize({"Up", 5})
  },

	{ -- Focus next pane
    key = "DownArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Next")
  },

	{ -- Focus previous pane
    key = "UpArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Prev")
  },

	{ -- Close pane
    key = "Escape",
    mods = "ALT",
    action = act.CloseCurrentPane({confirm = false})
  },

	{ -- Activate vi copy mode
    key = "X",
    mods = "CTRL",
    action = act.ActivateCopyMode
  },

	{ -- Paste from clipboard
    key = "V",
    mods = "CTRL",
    action = act.PasteFrom("Clipboard")
  },

	{ -- This lets us unify delete word across programs
    key = "Backspace",
    mods = "CTRL",
    action = act.SendKey({key = "w", mods = "CTRL"})
  },
}
-- Disable the default keybindings
config.disable_default_key_bindings = true

return config
