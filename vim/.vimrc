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

" History length
set history=1000

" Remap the <leader> to ,
nnoremap <Space> <Nop>
" let mapleader=','
" let maplocalleader = ','
let mapleader=' '

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
Plug 'scrooloose/nerdtree',     { 'on': 'NERDTreeToggle' }
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
Plug 'terryma/vim-multiple-cursors'
Plug 'bogado/file-line'
Plug 'vim-utils/vim-interruptless'

" ======== Snippets & Autocomplete ======================

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" ======== Appearence ===================================

Plug 'altercation/vim-colors-solarized'
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

" ======== Experimental =================================

Plug 'w0rp/ale'

call plug#end()



" ========================================================
" -> Functions
" ========================================================

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

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

function! TweakSolarized()
  " Some adjustments stolen from YADR project
  hi! link txtBold                      Identifier
  hi! link zshVariableDef               Identifier
  hi! link zshFunction                  Function
  hi! link rubyControl                  Statement
  hi! link rspecGroupMethods            rubyControl
  hi! link rspecMocks                   Identifier
  hi! link rspecKeywords                Identifier
  hi! link rubyLocalVariableOrMethod    Normal
  hi! link rubyStringDelimiter          Constant
  hi! link rubyString                   Constant
  hi! link rubyAccess                   Todo
  hi! link rubySymbol                   Identifier
  hi! link rubyPseudoVariable           Type
  hi! link rubyRailsARAssociationMethod Title
  hi! link rubyRailsARValidationMethod  Title
  hi! link rubyRailsMethod              Title
  hi! link rubyDoBlock                  Normal
  hi! link MatchParen                   DiffText
  hi! link CTagsModule                  Type
  hi! link CTagsClass                   Type
  hi! link CTagsMethod                  Identifier
  hi! link CTagsSingleton               Identifier
  hi! link javascriptFuncName           Type
  hi! link javascriptFunction           Statement
  hi! link javascriptThis               Statement
  hi! link javascriptParens             Normal
  hi! link jOperators                   javascriptStringD
  hi! link jId                          Title
  hi! link jClass                       Title
  hi! link NERDTreeFile                 Constant
  hi! link NERDTreeDir                  Identifier
  hi! link sassMixinName                Function
  hi! link sassDefinition               Function
  hi! link sassProperty                 Type
  hi! link htmlTagName                  Type
  hi! link Visual                       DiffChange
  hi! link Search                       DiffAdd
  hi! link Delimiter                    Identifier
  hi! link rDollar                      Identifier
  hi! link vimMapModKey                 Operator
  hi! link vimNotation                  Label
  hi! link htmlLink                     Include

  " Line numbers
  hi LineNR       ctermfg=23 ctermbg=8
  hi CursorLineNR ctermfg=23 ctermbg=8

  " Hide ~ at the bottom
  hi NonText cterm=NONE ctermfg=8

  " Status Line
  hi StatusLine   cterm=NONE ctermbg=0 ctermfg=23
  hi StatusLineNC cterm=NONE ctermbg=0 ctermfg=0

  " Misc adjustments
  hi WildMenu     cterm=NONE ctermbg=0    ctermfg=7
  hi Pmenu        cterm=NONE ctermbg=0    ctermfg=25
  hi PmenuSel     cterm=NONE ctermbg=0    ctermfg=7
  hi PmenuSbar    cterm=NONE ctermbg=0    ctermfg=7
  hi PmenuThumb   cterm=NONE ctermbg=0    ctermfg=7
  hi SpecialKey   cterm=NONE ctermbg=8    ctermfg=1
  hi CtrlPLinePre cterm=NONE ctermbg=8    ctermfg=8
  hi Folded       cterm=NONE ctermbg=0    ctermfg=4
  hi TabLine      cterm=NONE ctermbg=0    ctermfg=244
  hi TabLineFill  cterm=NONE ctermbg=0    ctermfg=4
  hi TabLineSel   cterm=NONE ctermbg=0    ctermfg=166
  hi VertSplit    cterm=NONE ctermbg=NONE ctermfg=0

  " GitGutter sign column adjustments
  hi GitGutterAdd          ctermbg=8 ctermfg=2
  hi GitGutterChange       ctermbg=8 ctermfg=3
  hi GitGutterDelete       ctermbg=8 ctermfg=1
  hi GitGutterChangeDelete ctermbg=8 ctermfg=3
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

let g:ale_sign_error = 'x'
let g:ale_sign_warning = '│'
let g:ale_echo_msg_format = '[%severity%] %s'

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}

" --- fzf

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Normal'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'Normal'],
  \ 'hl+':     ['fg', 'Normal'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Identifier'],
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



" ========================================================
" -> Autocommands
" ========================================================

if has("autocmd")
  au filetype help nnoremap <buffer><CR> <c-]>
  au filetype help nnoremap <buffer><BS> <c-T>
  au filetype help set nonumber

  au BufNewFile,BufRead Capfile,Gemfile,Vagrantfile setl ft=ruby
  au BufNewFile,BufRead *.rabl,*.jbuilder           setl ft=ruby

  au BufNewFile,BufRead *.phtml         setl ft=html
  " au BufNewFile,BufRead *.md,*.markdown setl ft=ghmarkdown

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
  au WinEnter * call CloseNERDTree()

  " Apply solarized tweak
  au ColorScheme solarized call TweakSolarized()

  " Prevent CtrlP or NERDTree from opening a split in Startify
  au User Startified setl buftype=
endif



" ========================================================
" -> Colors & Fonts
" ========================================================

" Solarized is love solarized is life
colorscheme solarized
set background=dark

set guifont=Source\ Code\ Pro:h16
if has('gui_running')
  set guifont=Menlo:h14
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
set tabline=%!Tabline()
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
" conceal mostly for markdown
set conceallevel=2

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %t
set statusline+=%m


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

" Use ripgrep if possible
if executable('rg')
  set grepprg=rg\ -i\ --vimgrep
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



" ========================================================
" -> Hotkeys & Bindings
" ========================================================

nnoremap ; :

nnoremap <silent> Q :q!<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

nnoremap ,, <C-^>

nnoremap <silent> <expr> <leader>f (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Files\<CR>"
nnoremap <silent> <expr> <leader>b (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Buffers\<CR>"
nnoremap <silent> <expr> <leader>s (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Snippets\<CR>"

nnoremap <silent> <leader>x :ALEFix<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>c <ESC>/\v^[<=>]{7}( .*\|$)<CR>
nnoremap <silent> <leader>t :tabnew<CR>
nnoremap <silent> <leader>d orequire 'pry'; binding.pry<ESC>
nnoremap <silent> <leader>D Orequire 'pry'; binding.pry<ESC>
nnoremap <silent> <leader>r :TestFile<CR>
nnoremap <silent> <leader>j :%!python -m json.tool<CR>
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader><space> :nohlsearch<CR>

nnoremap <silent> <leader>ga :Gwrite<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
nnoremap <silent> <leader>gup :Gpull<CR>
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gvdiff<CR>
nnoremap <silent> <expr> <leader>gl (expand('%') =~ 'NERD_tree' ? "\<C-w>\<C-w>" : '').":Commits\<CR>"

nnoremap <leader>p :echo @%<CR>

nnoremap <silent><Tab> :tabnext<CR>
nnoremap <silent><S-Tab> :tabprevious<CR>

nnoremap yy Y
nnoremap Y y$
nnoremap N Nzz
nnoremap n nzz
nnoremap j gj
nnoremap k gk
nnoremap H ^
nnoremap L $
nnoremap J mzJ`z
nnoremap gQ <Nop>

vnoremap . :normal .<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

xmap \  <Plug>Commentary
nmap \  <Plug>Commentary
nmap \\ <Plug>CommentaryLine

nnoremap <BS> :tabnew ~/iCloud/Wiki/index.md<CR>

nnoremap <silent>vv <c-w>v
" nnoremap <silent>ss <c-w>s TODO:

nmap <C-f> <Plug>CtrlSFPrompt 
nnoremap <silent><C-w> :call StripTrailingWhitespace()<CR>

inoremap <C-e> <END>
vnoremap <C-e> <END>
cnoremap <C-e> <END>
inoremap <C-a> <HOME>
vnoremap <C-a> <HOME>
cnoremap <C-a> <HOME>

" =====================================
" TODO: DEAL WITH THIS

" TODO: this requires double C-b for some reason
nnoremap <silent><C-b> :Gblame<CR>

" ,rh -> hashrocket to : TODO: think about it
" nnoremap <leader>rh :%s/\v:(\w+) \=\>/\1:/g<CR>

" ,s -> reload vimrc TODO: do something useful instead
" nnoremap <silent><leader>s :so ~/.vimrc<CR>
"
" nnoremap <silent><C-g> :Gitv<CR> TODO: No longer have gitv

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga      <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga      <Plug>(EasyAlign)

" Ctrl + e for emmet
imap <C-e> <C-y>, <CR>

" I don't use it
nnoremap K <nop>
" K reverse of J
" nnoremap K f<space>r<CR>
