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
map('v', ';', ':')
nmap(',,', '<C-^>')
-- TODO: stop this madness, :h autowrite
-- doesnt seem to work well in terminal
nmap('<leader>w', ':w<CR>')
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
-- nmap('K', '<Nop>')
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
map("n", "ga", "<Plug>(EasyAlign)")
map("x", "ga", "<Plug>(EasyAlign)")

-- nvim-tree.lua
-- nmap('<leader>n', ':NvimTreeToggle<CR>')
-- nmap('<leader>N', ':NvimTreeFindFile<CR>')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- glow.vim
nmap('<leader>p', ':Glow<CR>')

-- fugitive.vim
nmap('<leader>ga', ':Gwrite<CR>')
nmap('<leader>gs', ':Git<CR>')
nmap('<leader>gb', ':Git blame<CR>')

-- rails-vim
nmap('<leader>a', ':A<CR>')

-- test
nmap('<leader>r', function() os.execute("tmux send-keys -t '{down-of}' './bin/rspec '" .. vim.fn.expand("%") .. " Enter") end)
nmap('<leader>R', function() os.execute("tmux send-keys -t '{down-of}' './bin/rspec .' Enter") end)

-- CtrlSF
nmap('<C-f>', '<Plug>CtrlSFPrompt')

-- trim whitespace
nmap('<leader>W', ':TrimWhitespace<CR>')

-- EXPERIMENTAL:
nmap('<leader>x', ":call delete(expand('%')) | bdelete!<CR>")

nmap('<leader>q', ':copen<CR>')
nmap(']q', ':cnext<CR>')
nmap('[q', ':cprevious<CR>')

-- command mode
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')

-- paste in visual mode and keep available
local expr = { expr = true, noremap = false, silent = false }
vim.keymap.set('x', 'p', [['pgv"'.v:register.'y`>']], expr)
vim.keymap.set('x', 'P', [['Pgv"'.v:register.'y`>']], expr)

-- vim.keymap.set('n', 'gQ', 'mzgggqG`z<cmd>delmarks z<cr>zz', { desc = 'Format buffer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })

-- vim.keymap.set('n', '<leader>to', '<cmd>tabonly<cr>', { desc = 'Close other tab pages' })

-- Make U opposite to u.
-- vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
