" Author:      Konstantin Bukley <madundead@gmail.com>
" License:     WTFPL
" Description: Personal vim configuration



" ========================================================
" -> General
" ========================================================

" Turn off vi-compatible mode
set nocompatible

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Quantity of comand line entries vim have to remember
set history=500

" Remap the <leader> to ,
let mapleader=","
let g:mapleader=","

" Includes ftplugin.vim which is responsible for filetype detection
filetype plugin indent on

" Set syntax highlighting
syntax on



" ========================================================
" -> Plugins
" ========================================================

call plug#begin('~/.vim/plugged')

" ======== Languages / Textobjects =======================

Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'austintaylor/vim-indentobject'
Plug 'lucapette/vim-textobj-underscore'
Plug 'bootleq/vim-textobj-rubysymbol'

" ======== Utility  ======================================

Plug 'mattn/emmet-vim',
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree',     { 'on': 'NERDTreeToggle' }
Plug 'gregsexton/gitv',         { 'on': 'Gitv' }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'gregsexton/MatchTag',     { 'for': 'html' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
Plug 'Raimondi/delimitMate'
Plug 'nelstrom/vim-visual-star-search'
Plug 'benmills/vimux'
Plug 'skalnik/vim-vroom'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'bogado/file-line'
Plug 'ngmy/vim-rubocop'
Plug 'neomake/neomake'
Plug 'vim-utils/vim-interruptless'

" ======== Snippets & Autocomplete ======================

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" ======== Appearence ===================================

Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'machakann/vim-highlightedyank'

" ======== tpope <3  ====================================

Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails',     { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-git'
Plug 'tpope/vim-vinegar'

" ========= Some of my stuff  ===========================
" Bunch of helper functions extracted in their own plugin

Plug 'madundead/vim-madundead'

" ======== Experimental =================================

call plug#end()



" ========================================================
" -> Plugin settings
" ========================================================


" Enable matchit.vim
runtime macros/matchit.vim

" --- Netrw

let g:netrw_banner    = 0
let g:netrw_list_hide = '^\.$'
let g:netrw_liststyle = 4

" --- NERDTree

let NERDTreeWinPos           = "right"
let NERDTreeMinimalUI        = 1
let NERDTreeDirArrows        = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeHijackNetrw      = 1

" --- highlightedyank
"
let g:highlightedyank_highlight_duration = 400

" --- Ultisnips

let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

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

" --- vim-startify

let g:startify_relative_path          = 0
let g:startify_files_number           = 5
let g:startify_session_persistence    = 1
let g:startify_session_autoload       = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special         = 1
let g:startify_change_to_vcs_root     = 1
let g:startify_show_sessions          = 1
let g:startify_list_order =
  \ [
  \   [ ' > Recent: ' ],
  \   'dir',
  \   [ ' > Bookmarks: ' ],
  \   'bookmarks'
  \ ]
let g:startify_skiplist =
  \ [
  \   'COMMIT_EDITMSG',
  \   $VIMRUNTIME .'/doc',
  \   'bundle/.*/doc',
  \   '\.vimgolf',
  \ ]
let g:startify_custom_indices = [ '1', '2', '3', '4', '5', 'h', 'd', 'E', 'z' ]
let g:startify_bookmarks      = [ '~/', '~/Development', '~/.vimrc', '~/.zshrc' ]
let g:startify_custom_footer  = [ '', '   All work and no play makes Jack a dull boy', '' ]
let g:startify_custom_header  = []

" --- lightline
"
"  NOTE:  Proper status line marks require madundead/vim-madundead
"

let g:lightline =
  \ {
  \ 'enable': { 'tabline': 0 },
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
  \   'right': [],
  \ },
  \ 'inactive': {
  \   'right': [],
  \ },
  \ 'component_function': {
  \     'fugitive':     'madundead#lightline_fugitive',
  \     'filename':     'madundead#lightline_file_name',
  \     'fileformat':   'madundead#lightline_file_format',
  \     'filetype':     'madundead#lightline_file_type',
  \     'fileencoding': 'madundead#lightline_file_encoding',
  \     'mode':         'madundead#lightline_mode',
  \     'ctrlpmark':    'madundead#lightline_ctrlp',
  \   },
  \ }
let g:lightline.mode_map =
  \ {
  \ 'n' : ' N ',
  \ 'i' : ' I ',
  \ 'R' : ' R ',
  \ 'v' : ' V ',
  \ 'V' : ' V ',
  \ 'c' : ' N ',
  \ "\<C-v>": ' V ',
  \ 's' : 'S',
  \ 'S' : 'S',
  \ "\<C-s>": 'S',
  \ '?': '      '
  \ }



" ========================================================
" -> Colors & Fonts
" ========================================================

" solarized is love solarized is life
colorscheme solarized
set background=dark

" set guifont=Source\ Code\ Pro:h16
if has('gui_running')
  set guifont=Menlo:h14
  set guioptions-=T                         " remove toolbar
  set guioptions-=m                         " remove menubar
  set guioptions+=LlRrb                     " remove
  set guioptions-=LlRrb                     " scrollbars
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

" enables menu at the bottom
set wildmenu
" highlight search
set hlsearch
" nicer separators
set fillchars=diff:⣿,vert:│
" don't try to highlight lines longer than 800 characters.
set synmaxcol=200
" when a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread
" do not redraw while running macros
set lazyredraw
" tab label - requires vim-madundead
set tabline=%!madundead#tabline()
" show status even for single buffer displayed
set laststatus=2
" highlight current line
set cursorline
" number rows
set number
" disable welcome message
set shortmess+=I
" show matching braces
set showmatch
" shows when you are in insert mode
set showmode
" shows commands in right bottom corner
set showcmd
" show cursor position all the tiem
set ruler
" show title in console status bar
set title
" dont wrap lines
set nowrap
" when I scroll up or down, there are 2 lines between the line I'm on and the bottom or top of the screen.
set scrolloff=5
" how many tenths of a second to blink on matching brackets
set mat=2
" disable cursor blink
set gcr=a:blinkon0
" hide the mouse pointer while typing
set mousehide



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

" Dunno
set matchtime=2

" Force backspace to behave like in any other editor
set backspace=2

" Start searching as soon as you type first letter
set incsearch

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

" The minimal number of columns to scroll horizontally
set sidescroll=1

" Vertical splits in diff mode
set diffopt+=vertical

" Reduce delay between modes
set timeoutlen=1000 ttimeoutlen=0

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif



" ========================================================
" -> Indentations
" ========================================================

" Automatically inserts one extra level of indentation in some cases
set smartindent

" Affects how <TAB> key presses are interpreted depending on where the cursor is
set smarttab

" Tab counts as 2 columns
set tabstop=2

" Numbers of spaces to (auto)indent
set shiftwidth=2

" Spaces
set expandtab

" Don't write end of file
" set noeol



" ========================================================
" -> Filetype Dependent Settings
" ========================================================

if has("autocmd")
  au filetype help nnoremap <buffer><CR> <c-]>
  au filetype help nnoremap <buffer><BS> <c-T>
  au filetype help set nonumber

  au BufNewFile,BufRead Capfile,Gemfile,Vagrantfile setl ft=ruby
  au BufNewFile,BufRead *.rabl,*.jbuilder           setl ft=ruby

  au BufNewFile,BufRead *.phtml         setl ft=html
  au BufNewFile,BufRead *.md,*.markdown setl ft=ghmarkdown

  " Hide statusline
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
         \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

  " Only show cursorline in the current window and in normal mode.
  augroup cline
      au!
      au WinLeave,InsertEnter * set nocursorline
      au WinEnter,InsertLeave * set cursorline
  augroup END

  " Close tab if only NERDTree left
  au WinEnter * call madundead#nerdtree_close_hack()

  " Apply solarized tweak
  au VimEnter * call madundead#tweak_solarized()

  " Neomake
  au BufWritePost * Neomake

  " Prevent CtrlP or NERDTree from opening a split in Startify
  au User Startified setl buftype=
endif



" ========================================================
" -> Hotkeys & Bindings
" ========================================================
" Remap ; to :
nnoremap ; :

" Close buffer by Q
nnoremap <silent> Q :q!<CR>

" Move between splits (not very nice)
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>

" Move between splits (better backup option)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Bash like keys for the vim command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" ,<space> -> clears search highlight
nmap <silent><leader><space> :nohlsearch<cr>
" ,, -> toggle between last open buffers
nmap <leader><leader> <c-^>
" ,w -> strip trailing whitespace
nmap <silent><leader>w :call madundead#strip_trailing_whitespace()<CR>
" ,n -> NERDTree
nmap <silent><leader>n :NERDTreeToggle<CR>
" ,c -> next conflict marker
nmap <silent><leader>c <ESC>/\v^[<=>]{7}( .*\|$)<CR>
" ,b -> Gblame
nmap <leader>b :Gblame<CR>
" ,t -> opens new tab
nmap <leader>t :tabnew<CR>
" ,f -> prompts for search
nmap <leader>f :CtrlSF 
" ,g -> Gitv
nmap <leader>g :Gitv <CR>
" ,d -> binding fucking pry
nmap <leader>d orequire 'pry'; binding.pry<ESC>
" ,p -> current buffer file path
nmap <leader>p :echo @%<CR>
" ,s -> reload vimrc
nmap <silent><leader>s :so ~/.vimrc<CR>
      \ :call madundead#tweak_solarized()<CR>
" ,rh -> hashrocket to :
nmap <leader>rh :%s/\v:(\w+) \=\>/\1:/g<cr>

" Switching between tabs
nmap <silent><Tab> :tabnext<CR>
nmap <silent><S-Tab> :tabprevious<CR>

" n/N centers screen on the entry
nmap N Nzz
nmap n nzz

" Move faster
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
" Even in VISUAL mode
vnoremap <C-j> <C-d>
vnoremap <C-k> <C-u>

" Move properly when line wrapping is on
nnoremap j gj
nnoremap k gk

" Visual mode indentations
vnoremap < <gv
vnoremap > >gv

" Make Y/yy consistent with D/dd and C/cc
nnoremap yy Y
nnoremap Y y$

" vv/ss for splits
nnoremap <silent>vv <c-w>v
" nnoremap <silent>ss <c-w>s

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" Ctrl + e for emmet
imap <C-e> <C-y>, <CR>

" Allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

nnoremap H ^
nnoremap L $
nnoremap K <nop>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Keep old vim-commentary hotkeys
xmap \\  <Plug>Commentary
nmap \\  <Plug>Commentary
nmap \\\ <Plug>CommentaryLine
nmap \\u <Plug>CommentaryUndo

" git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gp :Gpush<CR>
noremap <Leader>gup :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gd :Gvdiff<CR>

" CtrlP -> fzf
nnoremap <C-p> :Files<Cr>

" TODO: Space should be used for something more useful
" Folding on <Space>

" NOTE: Keep this for future reference
" My attempt at git 2-way merging
" map <silent> <space>l :diffget //2<CR>:diffupdate<CR>
" map <silent> <space>h :diffget //3<CR>:diffupdate<CR>
" nnoremap <space>j ]cw
" nnoremap <space>k [cw
" map <silent> <space><w> :only<CR>:w<CR>

" REMINDERS:
" m         -- ruby method motion (e.g. cim)
" i         -- indentation motion (e.g. dai)
" gx        -- opens url in browser
" ctrl + e  -- emmet
" ctrl + n  -- vim-multiple-cursor
