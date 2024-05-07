return {
  --
  -- File explorer
  --

  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '\\', '<cmd>Neotree reveal<cr>', desc = 'Neotree' },
    },
  },


  --
  -- Statusline
  --

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    config = function()
      -- Define a function to check that ollama is installed and working
      local function get_condition()
          return package.loaded["ollama"] and require("ollama").status ~= nil
      end


      -- Define a function to check the status and return the corresponding icon
      local function get_status_icon()
        local status = require("ollama").status()

        if status == "IDLE" then
          return "OLLAMA IDLE"
        elseif status == "WORKING" then
          return "OLLAMA BUSY"
        end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'gruvbox-material',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
          extensions = {
            'neotree'
          },
        },
        tabline = {
          lualine_a = {'buffers'},
        };
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { get_status_icon, get_condition, 'encoding', 'fileformat', 'filetype' },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },


  --
  -- Git decorations
  --

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
}

