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
Plug 'jtratner/vim-flavored-markdown'
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

" ======== Experimental =================================

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()



" ========================================================
" -> Functions
" ========================================================

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFileName()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname == '__CtrlSF__' ? 'Results' :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : 'nothing') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ' '  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFileFormat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? "N" :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineCtrlP()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
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
  \     'fugitive':     'LightlineFugitive',
  \     'filename':     'LightlineFileName',
  \     'fileformat':   'LightlineFileFormat',
  \     'filetype':     'LightlineFileType',
  \     'fileencoding': 'LightlineFileEncoding',
  \     'mode':         'LightlineMode',
  \     'ctrlpmark':    'LightlineCtrlP',
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


" --- neomake

call neomake#configure#automake('rw')



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
  au WinEnter * call CloseNERDTree()

  " Apply solarized tweak
  au ColorScheme solarized call TweakSolarized()

  " Prevent CtrlP or NERDTree from opening a split in Startify
  au User Startified setl buftype=
endif



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

" Don't write end of file
" set noeol



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
nmap <silent><leader>w :call StripTrailingWhitespace()<CR>
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

" Avoid entering Ex mode by pressing gQ (Q is remapped below)
nnoremap gQ <nop>

" I don't use it
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

" EXPERIMENTAL:
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 240

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Goyo {{
  " Toggle distraction-free mode
  nnoremap <silent> <leader>g :Goyo<cr>

  fun! s:goyoEnter()
    set scrolloff=999 " Keep the edited line vertically centered
    set wrap
    set noshowcmd
    Limelight
  endf

  fun! s:goyoLeave()
    set showcmd
    set nowrap
    set scrolloff=5
    Limelight!
  endf

  autocmd! User GoyoEnter nested call <sid>goyoEnter()
  autocmd! User GoyoLeave nested call <sid>goyoLeave()
" }}
