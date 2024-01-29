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
        }
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
  }
}

