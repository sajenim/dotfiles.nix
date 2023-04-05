--
-- Vim Options
--

-- Disable vim's built in file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- {{{ General Configuration
vim.opt.termguicolors = true          -- set termguicolors to enable highlight groups
vim.opt.number        = true          -- print line numbers
vim.opt.showmode      = false         -- if in insert, replace or visual mode put a message on the last line
vim.opt.swapfile      = false         -- disable swap file
vim.opt.clipboard     = 'unnamedplus' -- use the system clipboard as the default register
-- }}}

-- {{{ Spaces & Tabs
vim.opt.tabstop     = 2     -- number of visual spaces per TAB
vim.opt.softtabstop = 2     -- number of spaces in tab when editing
vim.opt.shiftwidth  = 2     -- number of spaces to use for autoindent
vim.opt.expandtab   = true  -- tabs are space
vim.opt.autoindent  = true
vim.opt.copyindent  = true  -- copy indent from the previous line
-- }}}

-- {{{ Keybinds
vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap


map('n', '<leader>t', ':NvimTreeToggle<cr>', opts)
-- }}}

--
-- Gruvbox Material
-- 

-- For dark version
vim.opt.background = 'dark'

-- Set contrast
vim.g.gruvbox_material_background = 'hard'

-- For better performance
vim.g.gruvbox_material_better_performance = 0

-- To disable italic in `Comment`, set this option to `1`
vim.g.gruvbox_material_disable_italic_comment = 0

-- To enable bold in function name just like the original gruvbox, set this option to `1`
vim.g.gruvbox_material_enable_bold = 0

-- To enable italic in this color scheme, set this option to `1`
vim.g.gruvbox_material_enable_italic = 1

-- Set the colorscheme
vim.cmd [[colorscheme gruvbox-material]]


--
-- Load and run our libraries
--

-- load defaults
require('nvim-tree').setup()
require('Comment').setup()
require('gitsigns').setup()

-- user
require('user.lspconfig')
require('user.nvim-cmp')
require('user.lualine')

-- user.config
require('user.config.server_configurations')


-- Enable syntax highlighting
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  }
}

