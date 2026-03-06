return {
  -- File browser
  { 'nvim-tree/nvim-tree.lua' },
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- Multi cursor edit
  { 'mg979/vim-visual-multi' },

  -- Toggle comments
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },


  -- Git related plugins
  {'tpope/vim-fugitive'},
  {'tpope/vim-rhubarb'},
  {'tpope/vim-abolish'},
  {'tpope/vim-surround'},
  {'sindrets/diffview.nvim'},

  {'wsdjeg/vim-fetch'},

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Box draw
  { 'gyim/vim-boxdraw' },

  -- Detour: open temporary browsing popup window
  { 'carbon-steel/detour.nvim', config = function() vim.keymap.set('n', '<c-w><enter>', ':Detour<cr>') end },

  -- Table mode
  { 'dhruvasagar/vim-table-mode' },

  -- Add formatting supports
  { 'sbdchd/neoformat' },

  -- Add linting support
  { 'dense-analysis/ale' },

  -- UI theme
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- Lua Line setup
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      },
    },
  },

  -- Add doxygen support
  {
    'danymat/neogen',
    config = true,
  },

  -- Toggle zoom pane
  {
    'fasterius/simple-zoom.nvim',
    opts = {
      hide_tabline = true,
    },
  },

}
