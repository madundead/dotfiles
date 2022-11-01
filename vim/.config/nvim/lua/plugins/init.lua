local g = vim.g      -- a table to access global variables

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'shaunsingh/nord.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'tpope/vim-surround'
  use { 'junegunn/fzf', run = 'cd ~/.fzf && ./install --all' }
  use 'junegunn/fzf.vim'
  use 'junegunn/vim-easy-align'
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-repeat'
  use 'nvim-tree/nvim-tree.lua'
  use 'numtostr/comment.nvim'
  use 'ellisonleao/glow.nvim'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  use 'neovim/nvim-lspconfig'

  -- tpope
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'

  -- tests
  use 'vim-test/vim-test'
  use 'benmills/vimux'

  use 'dyng/ctrlsf.vim'

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  use "williamboman/mason.nvim"
  use "WhoIsSethDaniel/mason-tool-installer.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use({
    "williamboman/mason-lspconfig.nvim",
    requires = {
      "neovim/nvim-lspconfig",
    }
  })
  use 'AndrewRadev/splitjoin.vim'
end)

require 'plugins/treesitter'
require 'plugins/gitgutter'
require 'plugins/lsp'
require 'plugins/cmp'
require 'plugins/nord'
require 'plugins/nvim-tree'
require 'plugins/comment'
require 'plugins/mason'
require 'plugins/null-ls'
require 'plugins/telescope'

-- vim-test
g['test#strategy'] = 'vimux'

-- CtrlSF
g.ctrlsf_ackprg         = 'rg'
g.ctrlsf_regex_pattern  = 1
g.ctrlsf_case_sensitive = 'smart'
g.ctrlsf_default_root   = 'project'
g.ctrlsf_context        = '-B 1 -A 1'
g.ctrlsf_position       = 'bottom'
g.ctrlsf_winsize        = '40%'
g.ctrlsf_mapping        = {
  next = 'n',
  prev = 'N',
}
