" Author:      Konstantin Bukley <madundead@gmail.com>
" License:     WTFPL
" Description: Personal vim configuration


" ========================================================
" -> General
" ========================================================

set fileencoding=utf-8
nnoremap <Space> <Nop>
let mapleader=' '

" ========================================================
" -> Plugins
" ========================================================
"
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

call plug#begin('~/.vim/plugged')

" ======== Languages / Textobjects =======================

" Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'austintaylor/vim-indentobject'
Plug 'lucapette/vim-textobj-underscore'
Plug 'bootleq/vim-textobj-rubysymbol'

" ======== Utility  ======================================

Plug 'mattn/emmet-vim',
Plug 'scrooloose/nerdtree',     { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'gregsexton/MatchTag',     { 'for': 'html' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
Plug 'Raimondi/delimitMate'
Plug 'nelstrom/vim-visual-star-search'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi'
Plug 'bogado/file-line'
Plug 'vim-utils/vim-interruptless'
" Plug 'w0rp/ale'

" ======== Snippets & Autocomplete ======================

" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" ======== Appearence ===================================

Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'arcticicestudio/nord-vim'

" ======== tpope <3  ====================================

" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails',     { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-git'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'

" ======== Experimental =================================
Plug 'christoomey/vim-tmux-navigator'

" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'

call plug#end()



" ========================================================
" -> Functions
" ========================================================

function! StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    silent! call cursor(l, c)
endfunction

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab         = i + 1
    let winnr       = tabpagewinnr(tab)
    let buflist     = tabpagebuflist(tab)
    let bufnr       = buflist[winnr - 1]
    let bufname     = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

    if bufname == ''
      let s .= '  empty'
    elseif bufname =~ 'NERD_tree'
      let s .= '  tree'
    elseif bufname =~ 'ControlP'
      let s .= '  ctrlp'
    elseif bufname =~ 'FZF'
      let s .= '  fzf'
    elseif bufname =~ '__CtrlSF__'
      let s .= '  ctrlsf'
    else
      let s .= '  ' . fnamemodify(bufname, ':t')
    endif

    if bufmodified
      let s .= '(+)'
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction

function! CloseNERDTree()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction



" ========================================================
" -> Plugin settings
" ========================================================

" Enable matchit.vim
runtime macros/matchit.vim

" --- Netrw

let g:netrw_banner    = 0
let g:netrw_list_hide = '^\.$'
let g:netrw_liststyle = 4

" --- test

let test#strategy = "vimux"

" --- NERDTree

let NERDTreeWinPos           = "right"
let NERDTreeMinimalUI        = 1
let NERDTreeDirArrows        = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeHijackNetrw      = 1

" --- highlightedyank

let g:highlightedyank_highlight_duration = 400

" --- Ultisnips

let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" --- gitgutter

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'

" --- ale

" let g:ale_sign_error = 'x'
" let g:ale_sign_warning = '│'
" let g:ale_echo_msg_format = '[%severity%] %s'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_delay = 0

" let g:ale_linters = {
" \   'typescriptreact': ['tslint'],
" \   'javascript': ['tslint'],
" \   'typescript': ['tslint'],
" \}

" let g:ale_fixers = {
" \   'ruby': ['rubocop'],
" \}

" --- fzf

if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --no-info --color=gutter:#2E3440'
endif

command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'border': 'sharp' } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" --- CtrlSF

let g:ctrlsf_ackprg         = 'rg'
let g:ctrlsf_regex_pattern  = 1
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_root   = 'project'
let g:ctrlsf_context        = '-B 1 -A 1'
let g:ctrlsf_position       = 'bottom'
let g:ctrlsf_winsize        = '40%'
let g:ctrlsf_mapping        =
  \ {
  \   'next': 'n',
  \   'prev': 'N',
  \ }

" --- gist-vim

let g:gist_clip_command    = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_post_private    = 1
let g:gist_show_privates   = 1

" --- vimux

let g:vroom_use_vimux = 1



" ========================================================
" -> Autocommands
" ========================================================

if has("autocmd")
  au filetype help nnoremap <buffer><CR> <c-]>
  au filetype help nnoremap <buffer><BS> <c-T>
  au filetype help set nonumber

  au BufNewFile,BufRead *.docker setl ft=Dockerfile

  au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
  au FileType json setlocal equalprg=python\ -m\ json.tool

  " Hide statusline
  au! FileType fzf
  au  FileType fzf set laststatus=0 noshowmode noruler
       \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

  " Close tab if only NERDTree left
  au WinEnter * call CloseNERDTree()

  " Resize when the host window resized
  au VimResized * wincmd =
endif



" ========================================================
" -> Colors & Fonts
" ========================================================

colorscheme nord
set background=dark

set guifont=Fira\ Code\ Medium:h18
if has('gui_running')
  set guioptions-=T                         " Remove toolbar
  set guioptions-=m                         " Remove menubar
  set guioptions+=LlRrb                     " Remove
  set guioptions-=LlRrb                     " Scrollbars
  set t_Co=256
else
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
  set t_Co=16
endif



" ========================================================
" -> User Interface
" ========================================================

" Nicer separators
set fillchars=diff:⣿,vert:│
" Don't try to highlight lines longer than 800 characters.
set synmaxcol=200
" Do not redraw while running macros
set lazyredraw
" Tab label - requires vim-madundead
set tabline=%!Tabline()
" Number rows
set number
" Disable welcome message
set shortmess+=I
" Show matching braces
set showmatch
" Shows when you are in insert mode
set showmode
" Show title in console status bar
set title
" Dont wrap lines
set nowrap
" When I scroll up or down, there are 2 lines between the line I'm on and the bottom or top of the screen.
set scrolloff=5
" How many tenths of a second to blink on matching brackets
set mat=2
" Disable cursor blink
set gcr=a:blinkon0
" Hide the mouse pointer while typing
set mousehide
" Conceal mostly for markdown
set conceallevel=2
" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" Statusline
set statusline=%<%f

" ========================================================
" -> Behavior & Different Tricks
" ========================================================

" Shamelessly taken from YADR dotfile repo https://github.com/skwp/dotfiles
" Stuff to ignore whent tab completing
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
" Russian keymap support
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" W invokes sudo
command! W w !sudo tee % > /dev/null
" Use the OS clipboard by default (requires `+clipboard`)
set clipboard=unnamed
" Tenths of a second to show the matching paren
set matchtime=2
" Turn off visualbell
set novisualbell
" Fuck backups
set nobackup
set nowb
set noswapfile
" Doesn't select lines number in vim
set mouse=a
" Fancy whitespace characters
set list listchars=tab:→\ ,trail:·
" Abbrev. of messages (avoids 'hit enter')
set shortmess+=filmnrxoOtT
" Start scrolling when we're 8 lines away from margins
set scrolloff=8
" The minimal number of screen columns to keep to the left and to the
" right of the cursor if 'nowrap' is set.
set sidescrolloff=15
" Vertical splits in diff mode
set diffopt+=vertical
" Reduce delay between modes
set timeoutlen=1000 ttimeoutlen=0
" Use ripgrep if possible
if executable('rg')
  set grepprg=rg\ -i\ --vimgrep
endif
" Enables aliases from .bashrc in :! commands
set shellcmdflag=-ic



" ========================================================
" -> Indentations
" ========================================================

" Automatically inserts one extra level of indentation in some cases
set smartindent
" Tab counts as 2 columns
set tabstop=2
" Numbers of spaces to (auto)indent
set shiftwidth=2
" Spaces
set expandtab



" ========================================================
" -> Hotkeys & Bindings
" ========================================================

nnoremap ; :

nnoremap <silent> Q :q!<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap ,, <C-^>

nnoremap <silent><expr><leader>ff (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Files\<CR>"
nnoremap <silent><expr><leader>b (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Buffers\<CR>"
nnoremap <silent><expr><leader>gl (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Commits\<CR>"

nnoremap <silent><leader>a :A<CR>
nnoremap <silent><leader>x :ALEFix<CR>
nnoremap <silent><leader>n :NERDTreeToggle<CR>
nnoremap <silent><leader>N :NERDTreeFind<CR>
nnoremap <silent><leader>c <ESC>/\v^[<=>]{7}( .*\|$)<CR>
nnoremap <silent><leader>t :tabnew<CR>
nnoremap <silent><leader>d orequire 'pry'; binding.pry<ESC>
nnoremap <silent><leader>D oit { require 'pry'; binding.pry }<ESC>
nnoremap <silent><leader>r :TestFile<CR>
nnoremap <silent><leader>R :TestSuite<CR>
nnoremap <silent><leader>J :%!python -m json.tool<CR>
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q!<CR>
nnoremap <silent><leader>e :e!<CR>
nnoremap <silent><leader>= <C-w>=
nnoremap <silent><leader><space> :nohlsearch<CR>

nnoremap <silent><leader>ga :Gwrite<CR>
nnoremap <silent><leader>gs :Git<CR>
nnoremap <silent><leader>gb :Git blame<CR>

nnoremap <silent><Tab> :tabnext<CR>
nnoremap <silent><S-Tab> :tabprevious<CR>

" nnoremap <silent>vv <c-w>v
nnoremap <silent>vv :sp <CR>
nnoremap <silent><C-w> :call StripTrailingWhitespace()<CR>

nnoremap <leader>S :%s/\<<c-r><c-w>\>//g<left><left>

nnoremap yy Y
nnoremap Y y$
nnoremap N Nzz
nnoremap n nzz
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $
nnoremap J mzJ`z
nnoremap K <Nop>
nnoremap gQ <Nop>

vnoremap . :normal .<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

inoremap <C-e> <End>
vnoremap <C-e> <End>
cnoremap <C-e> <End>
inoremap <C-a> <Home>
vnoremap <C-a> <Home>
cnoremap <C-a> <Home>

nmap <C-f>   <Plug>CtrlSFPrompt
vmap <C-f>   <Plug>CtrlSFVwordPath
vmap <Enter> <Plug>(EasyAlign)
xmap ga      <Plug>(EasyAlign)
nmap ga      <Plug>(EasyAlign)


nnoremap <silent><expr><leader>e (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Files ~/Tmp\<CR>"
nnoremap <leader>E :e ~/Tmp/

" TODO Ignore .obsidian/
nnoremap <silent><expr><leader>o (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Files ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal\<CR>"
nnoremap <leader>O :e ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Personal

" EXPERIMENTAL STUFF
nnoremap <leader>ft <cmd>Telescope find_files<cr>
" nmap <leader>ft   <cmd>Telescope live_grep<cr>

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Fix gx
" https://github.com/vim/vim/issues/4738#issuecomment-856925080
nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
}
EOF

lua << EOF
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
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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
EOF

lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
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

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
