-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Log warnings or generate errors if we define an invalid configuration option
local config = wezterm.config_builder()

-- Install plugins
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

--
-- General configuration options.
--

-- Do not check for or show window with update information
config.check_for_updates = false

-- Font configuration
config.font = wezterm.font("Fisa Code")
config.font_size = 10.0

-- Enable gruvbox colour scheme
config.color_scheme = "gruvbox_material_dark_medium"

-- Pad window borders
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

--
-- Tab bar configuration options.
--

-- Disable modern tab bar
config.use_fancy_tab_bar = false
config.tab_max_width = 32

-- Tab bar colors
config.colors = {
	tab_bar = {
		background = "#32302f",
		active_tab = {
			bg_color = "#32302f",
			fg_color = "#7daea3",
			intensity = "Bold",
			italic = true,
		},
		inactive_tab = {
			bg_color = "#32302f",
			fg_color = "#a89984",
			intensity = "Bold",
			italic = true,
		},
		inactive_tab_hover = {
			bg_color = "#32302f",
			fg_color = "#a89984",
			intensity = "Bold",
			italic = true,
		},
		new_tab = {
			bg_color = "#32302f",
			fg_color = "#a89984",
			intensity = "Bold",
			italic = true,
		},
		new_tab_hover = {
			bg_color = "#32302f",
			fg_color = "#a89984",
			intensity = "Bold",
			italic = true,
		},
	},
}

--
-- Keymaps configuration.
--

-- Disable the default keybindings
config.disable_default_key_bindings = true

-- Setup leader key
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

-- General keymaps
config.keys = {
	--
	-- Tab management
	--

	{ -- Spawn new tab
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	{ -- Focus previous tab
		key = "PageUp",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	{ -- Focus next tab
		key = "PageDown",
		mods = "CTRL",
		action = wezterm.action.ActivateTabRelative(1),
	},

	--
	-- Pane management
	--

	{ -- Split pane vertically
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{ -- Split pane horizontally
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{ -- Close pane
		key = "q",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},

	--
	-- Copy / Paste
	--

	{ -- Activate vi copy mode
		key = "x",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},

	{ -- Paste from clipboard
		key = "p",
		mods = "LEADER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	--
	-- Miscellaneous
	--

	{ -- This lets us unify delete word across programs
		key = "Backspace",
		mods = "CTRL",
		action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
	},
}

--
-- Enable neovim integration
--

smart_splits.apply_to_config(config, {
	direction_keys = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
	modifiers = {
		move = "CTRL",
		resize = "CTRL|ALT",
	},
})

return config
