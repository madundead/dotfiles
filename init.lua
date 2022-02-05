-- Author:      Konstantin Bukley <madundead@gmail.com>
-- License:     WTFPL
-- Description: Personal neovim configuration

-- Helpers
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
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
end)

cmd('au TextYankPost * lua vim.highlight.on_yank { timeout = 250 }')
cmd('colorscheme nord')

opt.smartindent   = true            -- Autoindenting when starting a new line
opt.tabstop       = 2               -- Tab counts as 2 columns
opt.shiftwidth    = 2               -- Numbers of spaces to (auto)indent
opt.expandtab     = true            -- Tabs to spaces
opt.clipboard     = 'unnamed'       -- Share clipboard with the OS
opt.number        = true            -- Display line numbers
opt.fillchars     = 'diff:⣿,vert:│' -- Nicer separators
opt.synmaxcol     = 500             -- Do not try to highlight lines longer than 500 characters
opt.lazyredraw    = true            -- Do not redraw while running macros
opt.showmatch     = true            -- Show matching braces
opt.matchtime     = 2               -- Show matching braces for 2 tenths of second
opt.showmode      = true            -- Shows when you are in insert mode
opt.title         = true            -- Show title in console status bar
opt.wrap          = false           -- Dont wrap lines
opt.scrolloff     = 5               -- Keep 5 rows on the screen when scrolling
opt.sidescrolloff = 15              -- Horizontal scrolloff
opt.visualbell    = false           -- No visual bell
opt.backup        = false           -- No backups
opt.writebackup   = false           -- No backups
opt.swapfile      = false           -- No backups
opt.mouse         = 'a'             -- Support mouse (for proper mouse highlight)
opt.list          = true            -- List mode
opt.timeoutlen    = 1000            -- Delay for mappings
opt.ttimeoutlen   = 0               -- Delay between modes
opt.shellcmdflag  = '-ic'           -- Enables aliases from .bashrc in :! commands
opt.grepprg       = 'rg -i --vimgrep'           -- TODO: check for existance of rg otherwise fallback to grep
opt.diffopt:append({ vertical = true })         -- Vertical splits in diff mode
opt.shortmess:append({ I = true })              -- Remove welcome message (:intro)
opt.shortmess:append({ a = true })              -- Short messages for everything

-- Ignore when autocompleting TODO: review
opt.wildignore:append('*.o,*.obj,*~')
opt.wildignore:append('*vim/backups*')
opt.wildignore:append('*sass-cache*')
opt.wildignore:append('*DS_Store*')
opt.wildignore:append('vendor/rails/**')
opt.wildignore:append('vendor/cache/**')
opt.wildignore:append('*.gem')
opt.wildignore:append('log/**,tmp/**')
opt.wildignore:append('*.png,*.jpg,*.gif')

-- TODO :h gcr
-- " Disable cursor blink
-- set gcr=a:blinkon0
-- " Conceal mostly for markdown TODO :h conceallevel
-- set conceallevel=2
-- " Highlight VCS conflict markers TODO: translate to LUA
-- match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
-- " Russian keymap support TODO: do I still need this?
-- set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
-- " W invokes sudo TODO
-- command! W w !sudo tee % > /dev/null

g.mapleader = ' '

-- Netrw
g.netrw_banner    = 0
g.netrw_liststyle = 4

-- fzf
g.fzf_preview_window = ''
g.fzf_layout = { window = { width = 0.6, height = 0.6, border = 'sharp' } }

--- Mappings
-- Essentials
nmap(';', ':')
nmap(',,', '<C-^>')
nmap('<leader>w', ':w<CR>') -- TODO: stop this madness, :h autowrite
nmap('Q', ':q!<CR>')
nmap('<leader><space>', ':nohlsearch<CR>', { silent = true })

-- Convenience
nmap('yy', 'Y')
nmap('Y', 'y$')
nmap('N', 'Nzz')
nmap('n', 'nzz')
nmap('j', 'gj')
nmap('k', 'gk')
nmap('H', '^')
nmap('L', '$')
nmap('J', 'mzJ`z')
nmap('K', '<Nop>')
nmap('gQ', '<Nop>')

-- Tabs
nmap('<leader>t', ':tabnew<CR>')
nmap('<Tab>', ':tabnext<CR>')
nmap('<S-Tab>', ':tabprevious<CR>')
nmap('<leader>1', '1gt')
nmap('<leader>2', '2gt')
nmap('<leader>3', '3gt')
nmap('<leader>4', '4gt')
nmap('<leader>5', '5gt')

-- Visual mode
map('v', '.', ':normal .<CR>')
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- fzf
nmap('<leader>ff', ':Files<CR>')
nmap('<leader>ft', ':Files ~/Tmp<CR>')
nmap('<leader>fo', ":call fzf#run(fzf#wrap(fzf#vim#with_preview({ 'source': 'fd . --type f --extension=md --follow --exclude .git ~/ownCloud/Obsidian/Personal' })))<CR>", { silent = true })

-- vim-easy-align
map('x', 'ga', ':EasyAlign<CR>') -- TODO: this should allow for gaip, but does not
map('v', 'ga', ':EasyAlign<CR>')

-- Plugin config
-- Tree-sitter
require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = 'maintained',
  ignore_install = { 'norg' },
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
}
