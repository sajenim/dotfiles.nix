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

local function isViProcess(pane) 
    -- get_foreground_process_name On Linux, macOS and Windows, 
    -- the process can be queried to determine this path. Other operating systems 
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil
    -- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
            -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = 'ALT' }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

-- Do not check for or show window with update information
config.check_for_updates = false
config.show_update_window = false

-- Set our default shell to hilbish
config.default_prog = { 'hilbish' }

-- Font
config.font = wezterm.font 'Fira Code'
config.font_size = 10.0

-- Color scheme
config.color_scheme = 'gruvbox_material_dark_hard'

-- Padding
config.window_padding = {
  left   = 20,
  right  = 20,
  top    = 20,
  bottom = 0,
}

-- Tab bar appearance
config.use_fancy_tab_bar            = false
config.enable_tab_bar               = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom            = true
config.tab_max_width                = 24

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
  -- Tabs
  { key = 't', mods = 'ALT',      action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = "ALT|CTRL", action = act.CloseCurrentTab { confirm = false } },

  -- Panes
  { key = 'v', mods = 'ALT', action = act.SplitVertical    { domain  = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'ALT', action = act.SplitHorizontal  { domain  = 'CurrentPaneDomain' } },
  { key = 'x', mods = "ALT", action = act.CloseCurrentPane { confirm = false               } },
  -- Navigation
  { key = 'LeftArrow',  mods = 'ALT', action = act.EmitEvent('ActivatePaneDirection-left' ) },
  { key = 'DownArrow',  mods = 'ALT', action = act.EmitEvent('ActivatePaneDirection-down' ) },
  { key = 'UpArrow',    mods = 'ALT', action = act.EmitEvent('ActivatePaneDirection-up'   ) },
  { key = 'RightArrow', mods = 'ALT', action = act.EmitEvent('ActivatePaneDirection-right') },

  -- Clipboard
  { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode                         },
  { key = 'C', mods = 'CTRL', action = act.CopyTo    'ClipboardAndPrimarySelection' },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard'                    },
}

-- Bind tabs to number keys
for i = 1, 5 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

return config

