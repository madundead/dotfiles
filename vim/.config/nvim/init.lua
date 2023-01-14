-- Author:      Konstantin Bukley <madundead@gmail.com>
-- License:     WTFPL
-- Description: Personal neovim configuration

local cmd, fn, opt, g = vim.cmd, vim.fn, vim.opt, vim.g

require('impatient') -- Should be at the top
require('filetypes').config()

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
  -- Lua
  use { 'wbthomason/packer.nvim', opt = true }
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'shaunsingh/nord.nvim',
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
  use 'nvim-tree/nvim-tree.lua'
  use 'numtostr/comment.nvim'
  use 'ellisonleao/glow.nvim'

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

  -- TODO: make sense of it
  -- use "jose-elias-alvarez/null-ls.nvim"

  -- Vimscript
  use 'junegunn/vim-easy-align'
  use 'christoomey/vim-tmux-navigator'
  use 'lewis6991/gitsigns.nvim'

  -- tpope
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'

  -- tests
  use 'vim-test/vim-test'
  use 'benmills/vimux'

  -- TODO: find lua replacement / or learn :grep / cfdo
  use 'dyng/ctrlsf.vim'

  use 'andrewradev/splitjoin.vim'

  use {
    'vonheikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  use { "dstein64/vim-startuptime", cmd = "StartupTime" }

  -- EXPERIMENTAL: trying out different plugins
  use { 'phaazon/hop.nvim' }
end)

require('builtins')
require('plugins.gitgutter')
require('plugins.lsp')
require('plugins.nvim-tree')
require('plugins.comment')
require('plugins.gitsigns')
-- require('plugins.mason')
-- require('plugins.null-ls')
require('plugins.hop')
require('util')
require('settings')
require('mappings')
