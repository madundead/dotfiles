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
nmap('vv', ':vs<CR>')

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

-- vim-easy-align
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")

-- nvim-tree.lua
nmap('<leader>n', ':NvimTreeToggle<CR>')
nmap('<leader>N', ':NvimTreeFindFile<CR>')

-- glow.vim
nmap('<leader>p', ':Glow<CR>')

-- fugitive.vim
nmap('<leader>ga',':Gwrite<CR>')
nmap('<leader>gs',':Git<CR>')
nmap('<leader>gb',':Git blame<CR>')

-- rails-vim
nmap('<leader>a', ':A<CR>')

-- test
nmap('<leader>r', function() os.execute("tmux send-keys -t '{down-of}' 'bundle exec rspec '" .. vim.fn.expand("%") .. " Enter") end)
nmap('<leader>R', function() os.execute("tmux send-keys -t '{down-of}' 'bundle exec rspec .' Enter") end)

-- CtrlSF
nmap('<C-f>', '<Plug>CtrlSFPrompt')

-- trim whitespace
nmap('<leader>W', ':TrimWhitespace<CR>')


-- EXPERIMENTAL:
-- nmap('<leader>x', ':!rm %<CR>')
nmap('<leader>x', ":call delete(expand('%')) | bdelete!<CR>")
nmap('<leader>q', ':copen<CR>')
