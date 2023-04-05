-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font
config.font = wezterm.font 'Fisa Code'
config.font_size = 10.0

-- Color scheme
config.color_scheme = 'gruvbox_material_dark_hard'

-- Tab bar appearance
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.tab_max_width = 24

-- Colors
config.colors = {
  tab_bar = {
    background = '#1d2021',

    active_tab = {
      bg_color = '#1d2021',
      fg_color = '#d4be98',
      intensity = 'Normal',
    },

    inactive_tab = {
      bg_color = '#1d2021',
      fg_color = '#7c6f64',
      intensity = 'Half',
    },

    new_tab = {
      bg_color = '#1d2021',
      fg_color = '#7c6f64',
      intensity = 'Half',
    }
  }
}

-- Key Assignments
config.disable_default_key_bindings = true
config.keys = {
  {
    key = 'v',
    mods = 'ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  {
    key = 'h',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  {
    key = 'Tab',
    mods = 'ALT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 20 },
    },
  },

  {
    key = 'Backspace',
    mods = 'ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },

  { key = 'LeftArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Left',
  },

  {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Right',
  },

  {
    key = 'UpArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Up',
  },

  {
    key = 'DownArrow',
    mods = 'ALT',
    action = act.ActivatePaneDirection 'Down',
  },

  {
    key = 't',
    mods = 'ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },

  {
    key = 'w',
    mods = "ALT|CTRL",
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },

  {
    key = 'X',
    mods = 'CTRL',
    action = wezterm.action.ActivateCopyMode,
  },

  {
    key = 'C',
    mods = 'CTRL',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  },

  {
    key = 'V',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard',
  },
}
for i = 1, 5 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

-- Padding
config.window_padding = {
  left    = 20,
  right   = 20,
  top     = 20,
  bottom  = 0,
}

return config

