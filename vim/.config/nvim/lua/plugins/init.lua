local cmd, fn, opt, g = vim.cmd, vim.fn, vim.opt, vim.g

vim.loader.enable()

cmd [[packadd packer.nvim]]
local packer = require('packer')
local use = packer.use

-- NB: Difference between config and setup (https://github.com/wbthomason/packer.nvim#specifying-plugins)
--
-- `config` - Specifies code to run after this plugin is loaded.
--
-- The setup key implies opt = true
-- `setup` - Specifies code to run before this plugin is loaded. The code is ran even if
--           the plugin is waiting for other conditions (ft, cond...) to be met.

packer.startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  use {
    'shaunsingh/nord.nvim',
    config = function()
      require('plugins.nord').config()
    end,
    setup = function()
      require('plugins.nord').setup()
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        require('plugins/treesitter').config()
      end,
      requires = {
        {
          'nvim-treesitter/nvim-treesitter-textobjects',
          after = 'nvim-treesitter'
        },
        {
          'nvim-treesitter/playground',
          cmd = 'TSPlaygroundToggle',
        }
      }
  }

  use { 'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins/nvim-tree').config()
    end,
    opt = true,
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' }
  }

  use 'numtostr/comment.nvim'

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = fn.executable "make" == 1 }
  use { 'nvim-telescope/telescope.nvim',
    module = 'telescope',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins/telescope').config()
    end,
    setup = function()
      require('plugins/telescope').setup()
    end
  }

  -- Vimscript
  use { 'junegunn/vim-easy-align',
    -- opt = false,
    -- event = { 'BufRead', 'BufNewFile' },
    -- cmd = { 'EasyAlign' }
  }

  use 'christoomey/vim-tmux-navigator'
  use 'lewis6991/gitsigns.nvim'

  -- tpope
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'

  -- TODO: find lua replacement / or learn :grep / cfdo
  use 'dyng/ctrlsf.vim'

  use 'andrewradev/splitjoin.vim'

  use 'ggandor/leap.nvim'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use { "dstein64/vim-startuptime", cmd = "StartupTime" }

  -- EXPERIMENTAL: trying out different plugins
  use { 'skywind3000/asyncrun.vim' }

  use {'kevinhwang91/nvim-bqf', ft = 'qf'} -- better qf
end)

require('plugins.lsp')
require('plugins.cmp')
require('plugins.comment')
require('plugins.gitsigns')
