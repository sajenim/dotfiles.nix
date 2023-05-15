-- Use external source for diff
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

-- Configure the statusline
require('lualine').setup {
  options = {
    -- Set our theme and icon status
    icons_enabled = true,
    theme = 'gruvbox-material',

    -- Define our seperators
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},

    -- Disable some filetypes
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },

    -- If current filetype in in this list it'll
    -- always be drawn as inactive statusline
    ignore_focus = {},

    -- When set to true, left sections i.e. 'a','b' and 'c'
    -- can't take over the entire statusline even
    -- if neither of 'x', 'y' or 'z' are present.
    always_divide_middle = true,

    -- enable global statusline (have a single statusline
    -- at bottom of neovim instead of one for  every window).
    globalstatus = true,

    -- sets how often lualine should refreash it's contents (in ms)
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  -- Setup our active statusline components
  sections = {
    lualine_a = {'mode'},
    lualine_b = { {'FugitiveHead', icon = ''}, {'diff', source = diff_source}, 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },

  -- Setup our inactive statusline components
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },

  -- Setup our tabline components
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {'searchcount'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },

  -- Setup our winbar components
  winbar = {},
  inactive_winbar = {},

  -- Load our extensions
  extensions = {'fugitive', 'nvim-tree'}
}
