return {
  --
  -- Treesitter
  --

  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },


  --
  -- Fuzzy Finder
  --

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' , desc = 'Live Grep'  },
      { '<leader>fb', '<cmd>Telescope buffers<cr>'   , desc = 'Buffers'    },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' , desc = 'Help Tags'  },
    },
    config = function()
      require('telescope').setup()
    end
  },


  --
  -- Commenting
  --

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },


  --
  -- Git Commands
  --

  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    }
  },


  --
  -- Display Keybindings
  --

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = { },
  },

  --
  -- Delete Buffers
  --
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
    keys = {
      { '<leader>bd', '<cmd>Bdelete<cr>', desc = 'Buffer Delete' },
      { '<leader>bw', '<cmd>Bwipeout<cr>', desc = 'Buffer Wipeout' },
    },
  },
}

