local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

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
-- TODO: make the path relative to ~/Syncthing/Obsidian/Personal
nmap('<leader>fo', ":call fzf#run(fzf#wrap(fzf#vim#with_preview({ 'source': 'fd . --type f --extension=md --follow --exclude .git ~/Syncthing/Obsidian/Personal' })))<CR>", { silent = true })

-- vim-easy-align
map('x', 'ga', ':EasyAlign<CR>') -- TODO: this should allow for gaip, but does not
map('v', 'ga', ':EasyAlign<CR>')

-- nvim-tree.lua
nmap('<leader>n', ':NERDTreeToggle<CR>')
nmap('<leader>N', ':NERDTreeFind<CR>')

-- glow.vim
nmap('<leader>p', ':Glow<CR>')

-- fugitive.vim
nmap('<leader>ga',':Gwrite<CR>')
nmap('<leader>gs',':Git<CR>')
nmap('<leader>gb',':Git blame<CR>')

-- rails-vim
nmap('<leader>a', ':A<CR>')

-- test
nmap('<leader>r', ':TestFile<CR>')
nmap('<leader>R', ':TestSuite<CR>')

-- CtrlSF
nmap('<C-f>', '<Plug>CtrlSFPrompt')
