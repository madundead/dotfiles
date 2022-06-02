local g = vim.g      -- a table to access global variables

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'arcticicestudio/nord-vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use { 'junegunn/fzf', run = 'cd ~/.fzf && ./install --all' }
  use 'junegunn/fzf.vim'
  use 'junegunn/vim-easy-align'
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-repeat'
  use 'scrooloose/nerdtree' -- other file tree plugins are too fancy
  use 'ellisonleao/glow.nvim'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use 'neovim/nvim-lspconfig'

  -- tpope
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'

  -- tests
  use 'vim-test/vim-test'
  use 'benmills/vimux'

  use 'dyng/ctrlsf.vim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
end)

require 'plugins/treesitter'
require 'plugins/gitgutter'
require 'plugins/lsp'
require 'plugins/luasnip'

-- fzf
g.fzf_preview_window = ''
g.fzf_layout = { window = { width = 0.6, height = 0.6, border = 'sharp' } }

-- NERDTree
g.NERDTreeWinPos           = "right"
g.NERDTreeMinimalUI        = 1
g.NERDTreeDirArrows        = 1
g.NERDTreeAutoDeleteBuffer = 1
g.NERDTreeHijackNetrw      = 1

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

-- fzf
g.fzf_preview_window = ''
g.fzf_layout = { window = { width = 0.6, height = 0.6, border = 'sharp' } }
