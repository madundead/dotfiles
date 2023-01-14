-- Author:      Konstantin Bukley <madundead@gmail.com>
-- License:     WTFPL
-- Description: Personal neovim configuration

local cmd, fn, opt, g = vim.cmd, vim.fn, vim.opt, vim.g
local command = vim.api.nvim_create_user_command

require('impatient') -- Should be at the top
require('filetypes').config()

cmd [[packadd packer.nvim]]
local packer = require 'packer'
local use = packer.use

packer.startup(function()
  -- Lua
  use { 'wbthomason/packer.nvim', opt = true }
  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'
  use { 'shaunsingh/nord.nvim',
    config = function()
      require('plugins/nord').config()
    end,
    setup = function()
      require('plugins/nord').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      event = { 'BufRead', 'BufNewFile' },
      config = function()
        require('plugins/treesitter').config()
      end
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

  use "jose-elias-alvarez/null-ls.nvim"


  -- Vimscript
  use 'junegunn/vim-easy-align'
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'

  -- tpope
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-repeat'

  -- tests
  use 'vim-test/vim-test'
  use 'benmills/vimux'

  use 'dyng/ctrlsf.vim'

  use 'AndrewRadev/splitjoin.vim'

  use {
    'VonHeikemen/lsp-zero.nvim',
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
end)

require('builtins')
require 'plugins/gitgutter'
require 'plugins/lsp'
require 'plugins/nord'
require 'plugins/nvim-tree'
require 'plugins/comment'
require 'plugins/mason'
require 'plugins/null-ls'
require 'plugins/telescope'

cmd('au TextYankPost * lua vim.highlight.on_yank { timeout = 250 }')

g.ruby_host_prog = 'asdf exec neovim-ruby-host'

opt.smartindent   = true            -- Autoindenting when starting a new line
opt.completeopt = {'menu', 'menuone', 'noselect'}
opt.tabstop       = 2               -- Tab counts as 2 columns
opt.shiftwidth    = 2               -- Numbers of spaces to (auto)indent
opt.expandtab     = true            -- Tabs to spaces
opt.clipboard     = 'unnamedplus'   -- Share clipboard with the OS
opt.number        = true            -- Display line numbers
opt.fillchars = {
  vert = '▕',   -- alternatives │
  eob = ' ',    -- suppress ~ at EndOfBuffer
  msgsep = '‾',
  diff = '⣿',
  fold = ' ',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}
opt.synmaxcol     = 500             -- Do not try to highlight lines longer than 500 characters
opt.lazyredraw    = true            -- Do not redraw while running macros
opt.showmatch     = true            -- Show matching braces
opt.matchtime     = 2               -- Show matching braces for 2 tenths of second
opt.showmode      = true            -- Shows when you are in insert mode
opt.title         = true            -- Show title in console status bar
opt.laststatus    = 3               -- Single status line
opt.wrap          = false           -- Dont wrap lines
opt.scrolloff     = 5               -- Keep 5 rows on the screen when scrolling
opt.sidescrolloff = 15              -- Horizontal scrolloff
opt.visualbell    = false           -- No visual bell
opt.backup        = false           -- No backups
opt.writebackup   = false           -- No backups
opt.swapfile      = false           -- No backups
opt.mouse         = 'a'             -- Support mouse (for proper mouse highlight)
opt.list          = true            -- List mode
opt.listchars     = { trail = '·', tab = '->' }
opt.timeoutlen    = 1000            -- Delay for mappings
opt.ttimeoutlen   = 0               -- Delay between modes
opt.shellcmdflag  = '-ilc'          -- Enables aliases from .bashrc in :! commands
opt.termguicolors = true            -- 24-bit RGB color


if vim.fn.executable('rg') > 0 then
  vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
end

-- Use in vertical diff mode, blank lines to keep sides aligned, Ignore whitespace changes
opt.diffopt = vim.opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }

opt.shortmess = {
  t = true, -- truncate file messages at start
  A = true, -- ignore annoying swap file messages
  o = true, -- file-read message overwrites previous
  O = true, -- file-read message overwrites previous
  T = true, -- truncate non-file messages in middle
  f = true, -- (file x of x) instead of just (x of x
  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  I = true, -- disable welcome message (:intro)
  a = true, -- shortmess for everything
  c = true,
  W = true, -- Don't show [w] or written when writing
}

-- ignore when autocompleting
opt.wildignore = {
  '*.aux', '*.out', '*.toc', '*.o', '*.obj',
  '*.dll', '*.jar', '*.pyc', '*.rbc', '*.class',
  '*.gif', '*.ico', '*.jpg', '*.jpeg', '*.png',
  '*.avi', '*.wav', '*.*~', '*~ ', '*.swp',
  '.lock', '.DS_Store', 'tags.lock'
}

-- vim-test
g['test#strategy'] = 'neovim'

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

local function trim_trailing_whitespace()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[silent keepjumps keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
end
command('TrimWhitespace', trim_trailing_whitespace, {})

-- vim.cmd("set shell='bash -l'")

require('mappings')
