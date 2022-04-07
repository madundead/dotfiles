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
opt.listchars     = { trail = '·', tab = '->' }
opt.timeoutlen    = 1000            -- Delay for mappings
opt.ttimeoutlen   = 0               -- Delay between modes
opt.shellcmdflag  = '-ic'           -- Enables aliases from .bashrc in :! commands
opt.grepprg       = 'rg -i --vimgrep'           -- TODO: check for existence of rg otherwise fallback to grep
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

-- " Conceal mostly for markdown TODO :h conceallevel
-- set conceallevel=2
-- " Highlight VCS conflict markers TODO: translate to LUA
-- match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

g.mapleader = ' '

-- Netrw
g.netrw_banner    = 0
g.netrw_liststyle = 4

-- git-gutter
g.gitgutter_sign_added = '│'
g.gitgutter_sign_modified = '│'
g.gitgutter_sign_removed = '│'
g.gitgutter_sign_modified_removed = '│'
g.gitgutter_sign_removed_first_line = '│'

-- fzf
g.fzf_preview_window = ''
g.fzf_layout = { window = { width = 0.6, height = 0.6, border = 'sharp' } }

-- NERDTree
g.NERDTreeWinPos           = "right"
g.NERDTreeMinimalUI        = 1
g.NERDTreeDirArrows        = 1
g.NERDTreeAutoDeleteBuffer = 1
g.NERDTreeHijackNetrw      = 1

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
nmap('<leader>fo', ":call fzf#run(fzf#wrap(fzf#vim#with_preview({ 'source': 'fd . --type f --extension=md --follow --exclude .git ~/Syncthing/Obsidian/Personal' })))<CR>", { silent = true })

-- vim-easy-align
map('x', 'ga', ':EasyAlign<CR>') -- TODO: this should allow for gaip, but does not
map('v', 'ga', ':EasyAlign<CR>')

-- nvim-tree.lua
nmap('<leader>n', ':NERDTreeToggle<CR>')
nmap('<leader>N', ':NERDTreeFind<CR>')

-- glow.vim
nmap('<leader>p', ':Glow<CR>')

-- Plugin config
-- Tree-sitter
require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { 'bash', 'c', 'cpp', 'c_sharp', 'clojure', 'cmake', 'comment', 'commonlisp',
    'css', 'dockerfile', 'elixir', 'erlang', 'fish', 'go', 'html', 'http', 'java',
    'javascript', 'json', 'kotlin', 'latex', 'lua', 'make', 'markdown', 'perl', 'php',
    'python', 'ruby', 'rust', 'scss', 'swift', 'toml', 'tsx', 'vim', 'vue', 'yaml' },
  -- ignore_install = { 'norg' },
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
}

-------------------------------

-- TODO: figure out how to simplify the snippets config
-- TODO: figure out how to create custom snippets
-- TODO: is it possible to use luasnip without nvim-cpm?

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require("luasnip.loaders.from_vscode").lazy_load()



----------- LSP
require'lspconfig'.solargraph.setup{}
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
