-- https://github.com/SylvanFranklin/.config/blob/main/nvim/init.lua
-- new keymap defaults: https://neovim.io/doc/user/news-0.11.html
-- <c-w>d - diagnostics


-- 1. Plugins
-- requires nvim 0.12+
-- mise plugins add neovim
-- mise install neovim@nightly
-- https://github.com/jdx/mise/discussions/6787#discussioncomment-14803999

-- helper to reference GitHub repositories quickly
local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
  gh('shaunsingh/nord.nvim'),
  gh('stevearc/oil.nvim'),
  gh('christoomey/vim-tmux-navigator'),
  gh('tpope/vim-surround'),
  gh('tpope/vim-fugitive'),
  gh('kevinhwang91/nvim-bqf'),
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),
  gh('NickvanDyke/opencode.nvim')
})

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      "^%.git/", -- Use "^%.git/" to match the .git directory at the root
      "node_modules/.*",
    },
  }
})

require('oil').setup({
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false
  }
})


-- 2. Options
vim.opt.smartindent   = true          -- autoindenting when starting a new line
vim.opt.tabstop       = 2             -- tab counts as 2 columns
vim.opt.shiftwidth    = 2             -- numbers of spaces to (auto)indent
vim.opt.expandtab     = true          -- tabs to spaces
vim.opt.clipboard     = 'unnamedplus' -- share clipboard with the OS
vim.opt.number        = true          -- display line numbers
vim.opt.synmaxcol     = 500           -- do not try to highlight lines longer than 500 characters
vim.opt.lazyredraw    = true          -- do not redraw while running macros
vim.opt.showmatch     = true          -- show matching braces
vim.opt.matchtime     = 2             -- show matching braces for 0.2 sec
vim.opt.showmode      = true          -- shows when you are in insert mode
vim.opt.title         = true          -- show title in console status bar
vim.opt.laststatus    = 3             -- single status line
vim.opt.wrap          = false         -- dont wrap lines
vim.opt.scrolloff     = 5             -- keep 5 rows on the screen when scrolling
vim.opt.sidescrolloff = 15            -- horizontal scrolloff
vim.opt.visualbell    = false         -- no visual bell
vim.opt.backup        = false         -- no backups
vim.opt.writebackup   = false         -- no backups
vim.opt.swapfile      = false         -- no backups
vim.opt.mouse         = ''            -- disable mouse
vim.opt.list          = true          -- list mode
vim.opt.timeoutlen    = 1000          -- delay for mappings
vim.opt.ttimeoutlen   = 0             -- delay between modes
vim.opt.termguicolors = true          -- 24-bit RGB color
vim.opt.autoindent    = true
vim.opt.updatetime    = 100
vim.opt.timeout       = true
vim.opt.timeoutlen    = 1000
vim.opt.ttimeoutlen   = 10
vim.opt.autoread      = true -- for opencode
vim.opt.completeopt   = {
  'menu',
  'menuone',
  'noselect'
}
vim.opt.listchars     = {
  nbsp = '⦸', -- circled reverse solidus (U+29B8, UTF-8: E2 A6 B8)
  extends = '»', -- right-pointing double angle quotation mark (U+00BB, UTF-8: C2 BB)
  precedes = '«', -- left-pointing double angle quotation mark (U+00AB, UTF-8: C2 AB)
  trail = '•', -- bullet (U+2022, UTF-8: E2 80 A2)
  space = ' ',
  tab = '→ '
}
vim.opt.fillchars     = {
  diff = '⣿',
  eob = ' ', -- no-break space (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  vert = '│',
  msgsep = '‾',
  fold = '·', -- middle dot (U+00B7, UTF-8: C2 B7)
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸'
}
vim.opt.shortmess     = {
  t = true,               -- truncate file messages at start
  A = true,               -- ignore annoying swap file messages
  o = true,               -- file-read message overwrites previous
  O = true,               -- file-read message overwrites previous
  T = true,               -- truncate non-file messages in middle
  f = true,               -- (file x of x) instead of just (x of x
  F = true,               -- don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  I = true,               -- disable welcome message (:intro)
  a = true,               -- shortmess for everything
  c = true,
  W = true,               -- don't show w or written when writing
}
vim.opt.wildignore    = { -- ignore when autocompleting
  '*.aux', '*.out', '*.toc', '*.o', '*.obj',
  '*.dll', '*.jar', '*.pyc', '*.rbc', '*.class',
  '*.gif', '*.ico', '*.jpg', '*.jpeg', '*.png',
  '*.avi', '*.wav', '*.*~', '*~ ', '*.swp',
  '.lock', '.DS_Store', 'tags.lock'
}

if vim.fn.executable('rg') > 0 then
  vim.opt.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
end

-- find the correct ruby interpreter
-- vim.g.ruby_host_prog = 'mise exec neovim-ruby-host'
-- vim.g.python3_host_prog = 'mise exec -- python3'

-- highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank {
      higroup = 'Search',
      timeout = 250,
      on_visual = true,
    }
  end,
})

-- resize splits when Vim is resized
vim.api.nvim_create_autocmd('VimResized', { command = 'horizontal wincmd =' })

vim.api.nvim_create_augroup('cursorline_focus', {})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = 'cursorline_focus',
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = 'cursorline_focus',
  callback = function()
    vim.wo.cursorline = false
  end,
})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

--- Mappings
-- Essentials
vim.g.mapleader = ' '

vim.keymap.set('n', ';', ':')
vim.keymap.set('v', ';', ':')
vim.keymap.set('n', ',,', '<C-^>')
vim.keymap.set('n', 'Q', ':q!<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>') -- TODO: :h autowriteall
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>', { silent = true })

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files({ hidden = true }) end)
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers({ hidden = true }) end)
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)
vim.keymap.set('n', '<leader>fq', function() require('telescope.builtin').quickfix() end)
vim.keymap.set('n', '<leader>fo', function()
  require('telescope.builtin').find_files({ cwd = '~/Syncthing/Obsidian/Personal/', search_file = '*.md' })
end)
vim.keymap.set('n', '<leader>fO', function()
  require('telescope.builtin').live_grep({ cwd = '~/Syncthing/Obsidian/Personal/', search_file = '*.md' })
end)

-- Convenience
vim.keymap.set('n', 'yy', 'Y')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', 'gQ', '<Nop>')
vim.keymap.set('n', 'vv', ':vs<CR>')

-- Tabs
nmap('<leader>t', ':tabnew<CR>', { silent = true })
nmap('<Tab>', ':tabnext<CR>', { silent = true })
nmap('<S-Tab>', ':tabprevious<CR>', { silent = true })

-- Visual mode
map('v', '.', ':normal .<CR>')
map('v', 'J', ':m \'>+1<CR>gv=gv')
map('v', 'K', ':m \'<-2<CR>gv=gv')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- vim-easy-align
map("n", "ga", "<Plug>(EasyAlign)")
map("x", "ga", "<Plug>(EasyAlign)")

vim.keymap.set("n", "-", ":Oil<CR>")

-- fugitive.vim
nmap('<leader>ga', ':Gwrite<CR>')
nmap('<leader>gs', ':Git<CR>')
nmap('<leader>gb', ':Git blame<CR>')

-- test
nmap('<leader>r', function()
  os.execute("tmux send-keys -t '{down-of}' './bin/rspec '" .. vim.fn.expand("%") .. " Enter")
end)
nmap('<leader>R', function()
  os.execute("tmux send-keys -t '{down-of}' './bin/rspec .' Enter")
end)

-- grep
nmap('<C-f>', ':grep ')

-- reformat
vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, { silent = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

nmap('<leader>W', ':TrimWhitespace<CR>')

nmap('<leader>q', ':copen<CR>')

-- command mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')

-- paste in visual mode and keep available
vim.keymap.set('x', 'p', [['pgv"'.v:register.'y`>']], { expr = true, noremap = false, silent = false })
vim.keymap.set('x', 'P', [['Pgv"'.v:register.'y`>']], { expr = true, noremap = false, silent = false })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })

vim.keymap.set({ "n", "x" }, "<leader>ca", function() require("opencode").ask("@this: ", { submit = true }) end)
vim.keymap.set({ "n", "x" }, "<leader>cs", function() require("opencode").select() end)
vim.keymap.set({ "n", "t" }, "<leader>cc", function() require("opencode").toggle() end)

-- FIXME: doesn't work, maybe because of tmux?
vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end)
vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end)


-- Make U opposite to u.
-- vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- default
vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config['lua_ls'] = {
  cmd = { 'mise', 'x', '--', 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  settings = { Lua = { diagnostics = { globals = { "vim" } }, runtime = { version = 'LuaJIT' } } }
}
vim.lsp.enable('lua_ls')

-- ~/.local/state/nvim/lsp.log
vim.lsp.config['ruby-lsp'] = {
  cmd = { 'ruby-lsp' }, -- gem install ruby-lsp
  filetypes = { 'ruby' },
  root_markers = { 'Gemfile' },
}
vim.lsp.enable('ruby-lsp')

local function trim_trailing_whitespace()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[silent keepjumps keeppatterns %s/\s\+$//e]]
  vim.api.nvim_win_set_cursor(0, pos)
end
vim.api.nvim_create_user_command('TrimWhitespace', trim_trailing_whitespace, {})

vim.cmd('colorscheme nord')
